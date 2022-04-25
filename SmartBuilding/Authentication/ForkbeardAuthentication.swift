//
//  Authentication.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 11/04/2022.
//

import Foundation

struct ForkbeardAuthentication {
    // CHANGE:
    // Use the client identifier provided for use with the Forkbeard development,
    // or use the client identifier for you own authentication server.
    static let authClientId = "{client-id}"

    // CHANGE WHEN USING OWN AUTHENTICATION SERVER:
    // These values are currently set for use with the Forkbeard development environment.
    // Change these to match those for your own authentication server when applicable.
    static let authDomain = "https://forkbeard.eu.auth0.com/"

    // CHANGE WHEN USING APP FOR PRODUCTION:
    // This value can remain the same while in use with the Forkbeard development environment
    // Change this to a value specific for your own application when using your own authentication server.
    // Also change the respective value in the Info.plist and Simulator_Info.plist
    static let appRedirectScheme = "cloud.forkbeard.samples"

    // DO NOT CHANGE:
    // This is always required to be `https://phone.forkbeard.cloud`
    static let authAudience = "https://phone.forkbeard.cloud"

    // CHANGE:
    // Use the api key provided for use with the anonymous Forkbeard authentication.
    static let anonAuthApiKey = "5E93GDgNgBXAjuxPc8GymBJsPfM4p89W"

    enum AuthType {
        case openId, anonymous
    }

    // CHANGE:
    // Change this to the authentication type you want.
    static let currentAuthenticationMethod: AuthType = .anonymous;
}
