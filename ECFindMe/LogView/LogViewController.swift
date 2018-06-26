//
//  LogViewController.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-08.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit
import MapKit

class LogViewController : UIViewController{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recLabel: UILabel!
    @IBOutlet weak var speedDegreeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    static func storyboardInstance() -> LogViewController? {
        let storyboard: UIStoryboard? = UIStoryboard(name: "LogViewController", bundle: nil)
        var logViewController: LogViewController?
        if storyboard != nil{
            logViewController = storyboard?.instantiateViewController(withIdentifier: className) as? LogViewController
        }
        return logViewController
    }

    var locationItemDataArray:[LocationItem.sLocationItemData]  = []
    var currentRec = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        (_, locationItemDataArray) = AppDelegate.dataBase.getLocationItems()
        var currentLocation = CLLocationCoordinate2D(latitude: +43.653908, longitude: -79.384293)
        if( locationItemDataArray.count > 0 ){
            currentLocation = locationItemDataArray[0].locationCoor2D
        }
        let region = MKCoordinateRegion(center: currentLocation, span: AppDelegate.inheritedSpan!)
        mapView.setRegion(region, animated: false)

        initAllItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func markPosition(locationItemData: LocationItem.sLocationItemData ){
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationItemData.locationCoor2D
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        
        let newCamera:MKMapCamera = mapView.camera
        newCamera.heading = locationItemData.heading
        mapView.setCamera(newCamera, animated: false)
        
        mapView.setCenter(locationItemData.locationCoor2D, animated: true)
    }
    
    func initAllItems(){
        (_, locationItemDataArray) = AppDelegate.dataBase.getLocationItems()
        if( locationItemDataArray.count > 0 ){
            currentRec = 0
            updateViewLabelsMap()
        }
        else{
            dateLabel.text = "-"
            timeLabel.text = "-"
            recLabel.text = "0 / 0"
            speedDegreeLabel.text = "-"
            markPosition(locationItemData: LocationItem.sLocationItemData())
        }
    }
    
    internal func updateViewLabelsMap(){
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text        = dateFormatter.string(from: locationItemDataArray[currentRec].dateCreated! as Date)
        dateFormatter.dateFormat = "h:mm:ss a zzz"
        timeLabel.text        = dateFormatter.string(from: locationItemDataArray[currentRec].dateCreated! as Date)
        recLabel.text         = String( currentRec+1) + " / " + String(locationItemDataArray.count)
        speedDegreeLabel.text = String( locationItemDataArray[currentRec].speed )+" km/h, "+String( format:"%0.0lf", locationItemDataArray[currentRec].heading ) + "°"
        markPosition( locationItemData: locationItemDataArray[currentRec])
    }
    
    @IBAction func buttonGotoPrevView(_ sender: UIBarButtonItem) {
        print( "LogViewController: buttonGotoPrevView called" )
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonDeleteAll(_ sender: UIBarButtonItem) {
        print( "LogViewController: buttonDeleteAll called" )
        if( AppDelegate.displayAlert == nil ){
            AppDelegate.displayAlert = DisplayAlert()
            AppDelegate.displayAlert!.showDelAllLocationItems(title: "Will delete all location data", message: "OK to delete all?", viewController: self)
        }
    }
    
    @IBAction func buttonGotoTopRec(_ sender: UIBarButtonItem) {
        print( "LogViewController: buttonGotoTopRec called" )
        if( locationItemDataArray.count > 0 ){
            currentRec = 0
            updateViewLabelsMap()
        }
    }
    
    @IBAction func buttonGotoPrevRec(_ sender: UIBarButtonItem) {
        print( "LogViewController: buttonGotoPrevRec called" )
        if( locationItemDataArray.count > 0 && currentRec > 0 ){
            currentRec -= 1
            updateViewLabelsMap()
        }
    }
    
    @IBAction func buttonGotoNextRec(_ sender: UIBarButtonItem) {
        print( "LogViewController: buttonGotoNextRec called" )
        if( locationItemDataArray.count > 0 && currentRec < locationItemDataArray.count-1 ){
            currentRec += 1
            updateViewLabelsMap()
        }
    }
    
    @IBAction func buttonGotoLastRec(_ sender: UIBarButtonItem) {
        print( "LogViewController: buttonGotoLastRec called" )
        if( locationItemDataArray.count > 0 ){
            currentRec = locationItemDataArray.count-1
            updateViewLabelsMap()
        }
    }
}
