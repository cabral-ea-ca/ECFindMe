//
//  ViewController.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-03.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnNaviUsage: UIBarButtonItem!
    @IBOutlet weak var btnLockOrientation: UIBarButtonItem!
    @IBOutlet weak var authorizationLabel : UILabel!
    @IBOutlet weak var headingOrientation: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var naviUsage : CNaviUsage = CNaviUsage()
    var lockOrientation: CLockUsage = CLockUsage()
    
    var locationManager: CustCLLocationManager = CustCLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnNaviUsage.title = naviUsage.naviUsageDesc
        btnLockOrientation.title = lockOrientation.lockUsageDesc
        authorizationLabel.text = ""
        headingOrientation.text = ""
        locationLabel.text = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillTerminate(_:)), name: NSNotification.Name.UIApplicationWillTerminate, object: nil)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 10.0
        locationManager.headingFilter = 1.0
        
        let(_, appSettingsData) = AppDelegate.dataBase.getAppSettings()
        print( "ViewController: viewDidLoad \(appSettingsData.locationCoor2D) \(appSettingsData.regionSpan)" )
        let region = MKCoordinateRegion(center: appSettingsData.locationCoor2D, span: appSettingsData.regionSpan)
        mapView.setRegion(region, animated: false)
        mapView.setCenter(appSettingsData.locationCoor2D, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open var shouldAutorotate: Bool {
        return lockOrientation.lockUsageType == .kUnlocked
    }
    
    @objc func applicationDidBecomeActive(_ notification: NSNotification) {
        print ( "ViewController: applicationDidBecomeActive called" )
        checkLocationServ()
    }

    @objc func applicationWillTerminate(_ notification: NSNotification) {
        print ( "ViewController: applicationWillTerminate called" )
        let appSettingsData: AppSettings.sAppSettingsData = AppSettings.sAppSettingsData(locationCoor2D: mapView.centerCoordinate, regionSpan: mapView.region.span)
        _ = AppDelegate.dataBase.saveAppSettings(appSettingsData: appSettingsData)
    }

    internal func startNavi(){
        print( "ViewController: startNavi called" )
        if naviUsage.naviUsageType == .kNoNavi{
            mapView.showsUserLocation = false
            locationLabel.text = ""
        }
        else{
            mapView.showsUserLocation = true
            locationLabel.text = "Querying"
        }
        naviUsage.startNavi(locationManager: locationManager)
    }
    
    internal func checkNetwork(){
        print ( "ViewController: checkNetwork called" )
        startNavi()

        let(isReachable, _) = Reachability.isConnectedToNetwork()
        if isReachable {
            print("Internet Connection Available!")
            authorizationLabel.text = "✔"
        }else{
            print("Internet Connection not Available!")
            authorizationLabel.text = "✓"
            if( self.navigationController?.visibleViewController == self && AppDelegate.displayAlert == nil ){
                AppDelegate.displayAlert = DisplayAlert()
                AppDelegate.displayAlert!.showAlertNetwork(title: "Network", message: "Kindly turn on Wi-Fi or Cellular Data for map updates", viewController: self)
            }
        }
    }
    
    internal func checkLocationServ(){
        print ( "ViewController: checkLocationServ called" )
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways :
            print( "authorizedAlways not allowed" )
            
        case .authorizedWhenInUse :
            authorizationLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            locationManager.resetHeadingOrientation(uiLabel:headingOrientation)
            checkNetwork()
            
        case .denied :
            authorizationLabel.text = "✖"
            authorizationLabel.textColor = UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1)
            if( self.navigationController?.visibleViewController == self && AppDelegate.displayAlert == nil ){
                AppDelegate.displayAlert = DisplayAlert()
                AppDelegate.displayAlert!.showAlertLocation(title: "Location Services Setting", message: "Kindly allow the app to use it", viewController: self)
            }
            
        case .notDetermined :
            authorizationLabel.text = "❓"
            authorizationLabel.textColor = UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1)
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted :
            authorizationLabel.text = "❔"
            authorizationLabel.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        }
    }
    
    @IBAction func buttonOrientHeading(_ sender: UIBarButtonItem) {
        print( "ViewController: buttonOrientHeading called" )
        locationManager.resetHeadingOrientation(uiLabel:headingOrientation)
    }
    
    @IBAction func buttonLockUsage(_ sender: UIBarButtonItem) {
        print( "ViewController: buttonNaviUsage called" )
        lockOrientation.switchLock()
        sender.title = lockOrientation.lockUsageDesc
    }
    
    @IBAction func buttonNaviUsage(_ sender: UIBarButtonItem) {
        print( "ViewController: buttonNaviUsage called" )
        naviUsage.switchNavi(locationManager: locationManager)
        sender.title = naviUsage.naviUsageDesc
        startNavi()
    }
    
    @IBAction func buttonLogs(_ sender: UIBarButtonItem) {
        print( "ViewController: buttonLogs called" )
        let logViewNaviController: LogViewNaviController? = LogViewNaviController.storyboardInstance()
        if logViewNaviController != nil{
            naviUsage.naviUsageType = .kNoNavi
            btnNaviUsage.title = naviUsage.naviUsageDesc
            startNavi()
            AppDelegate.inheritedSpan = mapView.region.span
            self.present(logViewNaviController!, animated: true, completion: nil)
        }
        else{
            print( "Error cannot present LogViewNaviController storyboard" )
        }
    }
}
