//
//  LocationManagerDelegate.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-03.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import CoreLocation
import MapKit

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        print( "CLLocationManagerDelegate: didChangeAuthorization called" )
        checkLocationServ()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let lastLocationData = locations.last
        print( "CLLocationManagerDelegate: didUpdateLocations called ", lastLocationData as Any )
        
        // compute
        let speed : Int16 = (lastLocationData?.speed)! <= 0.0 ? 0 : Int16( ((lastLocationData?.speed)! * 3.6)+0.5 )
        locationLabel.text = String(format: "%0.5lf : ", (lastLocationData?.coordinate.latitude)! ) + String(format: "%0.5lf, ", (lastLocationData?.coordinate.longitude)!) + String(format: "%d km/h", speed )
        
        // compare current time with update interval
        let currentDate = lastLocationData!.timestamp
        var updateNow: Bool = false
        let custManager: CustCLLocationManager = manager as! CustCLLocationManager
        if custManager.lastTimeStamp == nil{
            custManager.lastTimeStamp = currentDate
            updateNow = true
        }
        else if custManager.updateInterVal > 0 && Int(currentDate.timeIntervalSince(custManager.lastTimeStamp!)) > custManager.updateInterVal {
            custManager.lastTimeStamp = currentDate
            updateNow = true
        }

        let newCamera:MKMapCamera = mapView.camera
        newCamera.heading = (lastLocationData?.course)!
        mapView.setCamera(newCamera, animated: false)
        
        mapView.setCenter((lastLocationData?.coordinate)!, animated: true)
        
        if updateNow == true {
            let locationItemData: LocationItem.sLocationItemData = LocationItem.sLocationItemData(dateCreated: lastLocationData?.timestamp as NSDate?, heading: (lastLocationData?.course)!, locationCoor2D: (lastLocationData?.coordinate)!, speed: speed)
            AppDelegate.dataBase.addLocationItem(locationItemData: locationItemData)
        }
    }
    
/*
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print( "CLLocationManagerDelegate: didUpdateHeading called ", newHeading.magneticHeading )
        let newCamera:MKMapCamera = mapView.camera
        newCamera.heading = newHeading.magneticHeading
        mapView.setCamera(newCamera, animated: true)
        if naviUsage.naviUsageType == .kUseForWalking {
            locationManager.stopUpdatingHeading()
        }
   }
*/

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("CLLocationManagerDelegate: didFailWithError called ", error )
    }
}
