//
//  NaviUsage.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-03.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import CoreLocation

class CNaviUsage{
    enum  NaviUsageType : Int {
        case kUnknown = -1
        case kNoNavi  = 0
        case kUseForWalking = 1
        case kFastNavigation = 2
        case kSFastNavigation = 3
    }
    
    internal var naviUsageType:NaviUsageType = .kNoNavi ;
    internal var typeStringTable = [
        "None" ,
        "Walking Navi" ,
        "Fast Navi" ,
        "Super Fast Navi" ,
    ]
    
    var naviUsageDesc : String {
        get { return typeStringTable[naviUsageType.rawValue] }
    }

   internal func naviUsageForFast(locationManager : CustCLLocationManager){
    print( "CNaviUsage: naviUsageForFast called"  )
        locationManager.stopUpdatingLocation()
        // locationManager.stopUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.activityType = .automotiveNavigation
        locationManager.headingFilter = 5.0
        locationManager.distanceFilter = 60.0
        locationManager.lastTimeStamp  = nil
        locationManager.updateInterVal = 30
        // locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
    internal func naviUsageForSFast(locationManager : CustCLLocationManager){
        print( "CNaviUsage: naviUsageForSFast called"  )
        locationManager.stopUpdatingLocation()
        // locationManager.stopUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.activityType = .otherNavigation
        locationManager.headingFilter = 5.0
        locationManager.distanceFilter = 120.0
        locationManager.lastTimeStamp  = nil
        locationManager.updateInterVal = 30
        // locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }

    internal func naviUsageForWalking(locationManager : CustCLLocationManager){
        print( "CNaviUsage: naviUsageForWalking called"  )
        locationManager.stopUpdatingLocation()
        // locationManager.stopUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.activityType = .fitness
        locationManager.headingFilter = 1
        locationManager.distanceFilter = 10.0
        locationManager.lastTimeStamp  = nil
        locationManager.updateInterVal = 15
        locationManager.startUpdatingLocation()
    }
    
    internal func naviUsageNone(locationManager : CustCLLocationManager){
        print( "CNaviUsage: naviUsageNone called"  )
        locationManager.stopUpdatingLocation()
        // locationManager.stopUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.activityType = .other
        locationManager.headingFilter = 90
        locationManager.distanceFilter = 3000
        locationManager.lastTimeStamp  = nil
        locationManager.updateInterVal = -1
    }

    func startNavi(locationManager : CustCLLocationManager){
        print( "CNaviUsage: startNavi called" )
        switch naviUsageType {
            case .kUnknown:          print( "What happened???" )
            case .kNoNavi:           naviUsageNone(locationManager : locationManager)
            case .kUseForWalking:    naviUsageForWalking(locationManager : locationManager)
            case .kFastNavigation:   naviUsageForFast(locationManager : locationManager)
            case .kSFastNavigation:   naviUsageForSFast(locationManager : locationManager)
        }
    }
    
    func switchNavi(locationManager : CustCLLocationManager){
        print( "CNaviUsage: switchNavi called" )
        let OldValue = naviUsageType
        switch naviUsageType {
        case .kUnknown:
            print( "What happened???" )

        case .kNoNavi:
            naviUsageType = .kUseForWalking
            
        case .kUseForWalking:
            naviUsageType = .kFastNavigation
            
        case .kFastNavigation:
            naviUsageType = .kSFastNavigation
            
        case .kSFastNavigation:
            naviUsageType = .kNoNavi
        }
        print( "naviUsageNone called \(OldValue) -> \(naviUsageType)" )

        startNavi(locationManager: locationManager)
    }
}
