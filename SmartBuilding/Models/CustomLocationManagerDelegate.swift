

import Foundation
import PhoneFUEL


class CustomLocationManagerDelegate: NSObject, SPFLocationManagerDelegate {

    func spfLocationManager(_ manager: SPFLocationManager, didUpdate location: SPFLocation?)
    {
        NSLog("Received new location data.");
    }


    func spfLocationManager(_ manager: SPFLocationManager, stateChanged state: SPFState?, withError error: Error?)
    {
        NSLog("State of positioning engine changed.");
    }
}



