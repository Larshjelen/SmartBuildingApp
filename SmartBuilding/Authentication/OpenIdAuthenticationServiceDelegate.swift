//
//  OpenIdAuthenticationServiceDelegate.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 11/04/2022.
//

import Foundation
import AppAuth
import PhoneFUEL

typealias loginCallback = (_ success: Bool) -> Void

class OpenIdAuthenticationServiceDelegate: NSObject {

    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        loadState()
    }

    private var viewController: UIViewController?
    private var authState: OIDAuthState?
    
    func login(loginCallback: @escaping loginCallback) {
        guard let issuer = URL(string: ForkbeardAuthentication.authDomain) else {
            NSLog("Error creating URL for : \(ForkbeardAuthentication.authDomain)")
            return
        }

        NSLog("Fetching configuration for issuer: \(issuer)")

        // discovers endpoints
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in

            guard let config = configuration else {
                NSLog("Error retrieving discovery document: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                self.setAuthState(nil)
                return
            }
            
            guard let redirectURL = URL(string: ForkbeardAuthentication.appRedirectScheme + "://app") else {
                NSLog("Error creating URL from Authentication.appRedirectScheme")
                self.setAuthState(nil)
                return
            }
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                NSLog("Error accessing AppDelegate")
                self.setAuthState(nil)
                return
            }
            
            guard let viewController = self.viewController else {
                NSLog("Error accessing viewController")
                self.setAuthState(nil)
                return
            }
            
            // builds authentication request
            let request = OIDAuthorizationRequest(configuration: config,
                                                  clientId: ForkbeardAuthentication.authClientId,
                                                  clientSecret: nil,
                                                  scopes: [OIDScopeOpenID],
                                                  redirectURL: redirectURL,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: ["audience": ForkbeardAuthentication.authAudience, "prompt": "login"])
            
            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: viewController) { authState, error in
                if let authState = authState {
                    self.setAuthState(authState)
                    if self.isAuthorized() {
                        loginCallback(true)
                    } else {
                        loginCallback(false)
                    }
                } else {
                    self.setAuthState(nil)
                    loginCallback(false)
                }
            }
    
        }
    }

    func logout() {
        authState?.update(with: nil)
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.openIdToken)
    }

    func isAuthorized() -> Bool {
        return authState?.isAuthorized ?? false
    }

    private func ensureFreshTokenSync() {
        let lock = NSLock()
        authState?.performAction(freshTokens: {_,_,_ in
            lock.unlock()
        })
        lock.lock()
        lock.lock()
    }
    
    func saveState() {
        var data: Data? = nil

        if let authState = self.authState {
            data = NSKeyedArchiver.archivedData(withRootObject: authState)
        }

        UserDefaults.standard.set(data, forKey: UserDefaults.Keys.openIdToken)
        UserDefaults.standard.synchronize()
    }

    func loadState() {
        guard let data = UserDefaults.standard.object(forKey: UserDefaults.Keys.openIdToken) as? Data else {
            return
        }

        if let authState = NSKeyedUnarchiver.unarchiveObject(with: data) as? OIDAuthState {
            self.setAuthState(authState)
        }
    }

    func setAuthState(_ authState: OIDAuthState?) {
        if (self.authState == authState) {
            return;
        }
        self.authState = authState;
        self.authState?.stateChangeDelegate = self;
        self.stateChanged()
    }
    
    func stateChanged() {
        self.saveState()
    }
}

extension OpenIdAuthenticationServiceDelegate: OIDAuthStateChangeDelegate, OIDAuthStateErrorDelegate {
    func didChange(_ state: OIDAuthState) {
        self.stateChanged()
    }

    func authState(_ state: OIDAuthState, didEncounterAuthorizationError error: Error) {
        NSLog("Received authorization error: \(error)")
    }
}

extension OpenIdAuthenticationServiceDelegate: SPFLocationServiceAuthenticationDelegate {
    func onGetToken() -> String? {
        if !(authState?.isAuthorized ?? false) ||
            authState?.lastTokenResponse?.accessTokenExpirationDate?.timeIntervalSinceNow.isLessThanOrEqualTo(60) ?? false {
            ensureFreshTokenSync()
        }
        return authState?.lastTokenResponse?.accessToken
    }
}

extension UserDefaults.Keys {
    static let openIdToken = "open_id_token"
}
