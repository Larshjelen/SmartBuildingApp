

import Foundation
import PhoneFUEL


class CustomLocationManagerDelegate: NSObject, SPFLocationManagerDelegate {

    func spfLocationManager(_ manager: SPFLocationManager!, didUpdate location: SPFLocation!)
    {
        NSLog("Received new location data.");
    }


    func spfLocationManager(_ manager: SPFLocationManager!, stateChanged state: SPFState!, withError error: Error!)
    {
        NSLog("State of positioning engine changed.");
    }
}

class CustomAuthenticationDelegate: NSObject, SPFLocationServiceAuthenticationDelegate {

    func onGetToken() {
        return "<token>";
    }
}

var delegate = CustomAuthenticationDelegate();
SPFLocationService.setAuthenticationDelegate(delegate);


try SPFLocationService.setAuthenticationAnonymous(Authentication.anonAuthApiKey)
