//
//  AppDelegate.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//
import UIKit
import GoogleMaps
import AppAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    var currentAuthorizationFlow: OIDExternalUserAgentSession?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // CHANGE:
        // Add your Google Maps API key here:
        GMSServices.provideAPIKey("AIzaSyArBUnnKq2JNGSuTUuFwWjaYiUgRJldYqs")
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      if currentAuthorizationFlow?.resumeExternalUserAgentFlow(with: url) ?? false {
        currentAuthorizationFlow = nil
        return true
      }
      return false
    }

}

