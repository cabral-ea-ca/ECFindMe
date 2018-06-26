//
//  AppSettings+CoreDataProperties.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-05.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

import CoreData
import CoreLocation
import MapKit

extension AppSettings {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppSettings> {
        return NSFetchRequest<AppSettings>(entityName: "AppSettings")
    }

    @NSManaged public var lastUpdate: NSDate?
    @NSManaged public var lastLatitude: Double
    @NSManaged public var lastLongitude: Double
    @NSManaged public var lastLatitudeDelta: Double
    @NSManaged public var lastLongitudeDelta: Double

    class func getRecord(entity: NSEntityDescription, managedObjectContext: NSManagedObjectContext) -> (Bool, AppSettings?, sAppSettingsData) {
        let appSettingsFetchReq : NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        appSettingsFetchReq.entity = entity
        var retBool = false
        var retAppSettings:AppSettings?
        var retAppSettingsData: sAppSettingsData = sAppSettingsData()
        do {
            let records = try managedObjectContext.fetch(appSettingsFetchReq as! NSFetchRequest<NSFetchRequestResult>)
            print( "AppSettings: No of records \(records.count)")
            
            if (records.count == 1 ) {
                let appSettings = records[0] as! AppSettings
                print( "\(String(describing: appSettings.lastUpdate)) \(appSettings.lastLatitude) \(appSettings.lastLongitude) \(appSettings.lastLatitudeDelta) \(appSettings.lastLongitudeDelta)" )
                retAppSettings = appSettings
                retAppSettingsData.locationCoor2D = CLLocationCoordinate2D(latitude: appSettings.lastLatitude, longitude: appSettings.lastLongitude)
                retAppSettingsData.regionSpan     = MKCoordinateSpan(latitudeDelta: appSettings.lastLatitudeDelta, longitudeDelta: appSettings.lastLongitudeDelta)
                retBool = true
            }
            else{
                print( "AppSettings: Why has \(records.count) records" )
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return (retBool, retAppSettings, retAppSettingsData)
    }
    
    func saveRecord( appSettingsData: AppSettings.sAppSettingsData, managedObjectContext: NSManagedObjectContext ){
        lastUpdate = NSDate()
        lastLatitude       = appSettingsData.locationCoor2D.latitude
        lastLongitude      = appSettingsData.locationCoor2D.longitude
        lastLatitudeDelta  = appSettingsData.regionSpan.latitudeDelta
        lastLongitudeDelta = appSettingsData.regionSpan.longitudeDelta
        do {
            try managedObjectContext.save()
            print( "AppSettings: saveAppSettings OK" )
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
}
