//
//  RebelOpenIdAuthDelegate.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 19/04/2022.
//

import Foundation
import AppAuth


typealias RebelloginCallback = (_ success: Bool) -> Void

class RebelOpenIdAuthDelegate: NSObject {

    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
       
    }

    private var viewController: UIViewController?
    private var authState: OIDAuthState?
    
    func login(loginCallback: @escaping loginCallback) {
        guard let issuer = URL(string: RebelAuthentication.authDomain) else {
            NSLog("Error creating URL for : \(RebelAuthentication.authDomain)")
            return
        }

        NSLog("Fetching configuration for issuer: \(issuer)")

        // discovers endpoints
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in

            guard let config = configuration else {
                NSLog("Error retrieving discovery document: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                
                return
            }
            
            guard let redirectURL = URL(string: RebelAuthentication.redirectUrl) else {
                NSLog("Error creating URL from Authentication.appRedirectScheme")
                
                return
            }
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                NSLog("Error accessing AppDelegate")
                
                return
            }
            
            guard let viewController = self.viewController else {
                NSLog("Error accessing viewController")
                
                return
            }
            
            // builds authentication request
            let request = OIDAuthorizationRequest(configuration: config,
                                                  clientId: RebelAuthentication.clientId,
                                                  clientSecret: nil,
                                                  scopes: [OIDScopeOpenID],
                                                  redirectURL: redirectURL,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)
            
            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: viewController) { authState, error in
                if let authState = authState {
                print( "authstate : ",authState)
            }
    
        }
    }
    }

}
