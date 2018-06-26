//
//  CustCLLocationManager.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-04.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit
import CoreLocation

class CustCLLocationManager : CLLocationManager{
    var updateInterVal:Int = -1
    var lastTimeStamp: Date?
    func resetHeadingOrientation(uiLabel : UILabel){
        print ( "CustCLLocationManager: resetHeadingOrientation called" )
        switch( UIApplication.shared.statusBarOrientation ){
            case .landscapeLeft :       print("landscapeLeft")
            case .landscapeRight :      print("landscapeRight")
            case .portrait :            print("portrait")
            case .portraitUpsideDown :  print("portraitUpsideDown")
            case .unknown :             print("unknown")
        }
        
        self.stopUpdatingLocation()
        // self.stopUpdatingHeading()
        
        let orientation : CLDeviceOrientation = CLDeviceOrientation(ui: UIApplication.shared.statusBarOrientation )
        
        if orientation != .unknown{
            self.headingOrientation = orientation
            switch (orientation){
                case .landscapeLeft :       uiLabel.text = "➡"
                case .landscapeRight :      uiLabel.text = "⬅"
                case .portrait :            uiLabel.text = "⬆"
                case .portraitUpsideDown :  uiLabel.text = "⬇"
                default :                   uiLabel.text = "???"
            }
        }
        else{
            uiLabel.text = ""
        }
        // self.startUpdatingHeading()
        self.startUpdatingLocation()
    }
}
