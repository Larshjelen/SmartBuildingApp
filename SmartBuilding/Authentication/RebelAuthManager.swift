//
//  RebelAuthManager.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/04/2022.
//

import Foundation
import AuthenticationServices
import AppAuth


class RebelAuthManager : NSObject{
  
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
    }
    
    override init(){
        super.init()
    }
    
    let issuer = URL(string: "https://entrasso-qa.entraos.io/oauth2")
    private var authState: OIDAuthState?
    
    private var viewController: UIViewController?
    
    func login(){
        
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer!) { configuration, error in
          guard let config = configuration else {
            print("Error retrieving discovery document: \(error?.localizedDescription ?? "Unknown error")")
            return
          }
            
            guard let redirectURL = URL(string: RebelAuthentication.redirectUrl) else {
                NSLog("Error creating URL from Authentication.appRedirectScheme")
                self.setAuthState(nil)
                return
            }
            
            guard let viewController = self.viewController else {
                NSLog("Error accessing viewController")
                self.setAuthState(nil)
                return
            }
            
            let request = OIDAuthorizationRequest(configuration:config , clientId: RebelAuthentication.clientId,
                                                  clientSecret:RebelAuthentication.clientSecret ,
                                                  scopes: [OIDScopeOpenID,OIDScopeProfile, OIDScopeEmail, OIDScopePhone],
                                                  redirectURL: redirectURL,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: ["audience": RebelAuthentication.rebelAuthAudience, "prompt": "login"])
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            appDelegate.currentAuthorizationFlow =
            OIDAuthState.authState(byPresenting: request, presenting: viewController ) { authState ,error in
              if let authState = authState {
                self.setAuthState(authState)
               // print("Got authorization tokens. Access token: " +
                 //     "\(authState.lastTokenResponse?.accessToken ?? "nil")")
                 
                  
              } else {
                print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
                self.setAuthState(nil)
              }
            }

      }
        
      
  }
    
    func saveRebelToken (){
        
        UserDefaults.standard.set(authState?.lastTokenResponse?.accessToken, forKey: UserDefaults.Keys.rebelOpenIdToken)
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
        self.saveRebelToken()
    }
    
    func logout(){
        authState?.update(with: nil)
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.rebelOpenIdToken)
        print("loggin out...")
        
    }
    
    func getSavedRebelToken() -> String{
        guard let savedToken = UserDefaults.standard.object(forKey: UserDefaults.Keys.rebelOpenIdToken) as? String else {return "nil"}
        return savedToken
    }
    


}

extension RebelAuthManager: OIDAuthStateChangeDelegate, OIDAuthStateErrorDelegate {
    func authState(_ state: OIDAuthState, didEncounterAuthorizationError error: Error) {
        print("Received authorization error: \(error)")
    }
    
    func didChange(_ state: OIDAuthState) {
        self.stateChanged()
    }

}

extension UserDefaults.Keys {
    static let rebelOpenIdToken = "rebelOpenIdToken"
}
