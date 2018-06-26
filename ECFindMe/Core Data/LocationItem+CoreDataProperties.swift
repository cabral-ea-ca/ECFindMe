//
//  LocationItem+CoreDataProperties.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-05.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//


import CoreData
import CoreLocation

extension LocationItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationItem> {
        return NSFetchRequest<LocationItem>(entityName: "LocationItem")
    }
    
    @NSManaged internal var dateCreated: NSDate?
    @NSManaged internal var heading: Double
    @NSManaged internal var latitude: Double
    @NSManaged internal var longitude: Double
    @NSManaged internal var speed: Int16
    @NSManaged internal var relLocationList: LocationList?
    
    func addRecord( locationItemData: sLocationItemData, locationList: LocationList, managedObjectContext: NSManagedObjectContext ){
        dateCreated     = locationItemData.dateCreated == nil ? NSDate() : locationItemData.dateCreated
        heading         = locationItemData.heading
        latitude        = locationItemData.locationCoor2D.latitude
        longitude       = locationItemData.locationCoor2D.longitude
        speed           = locationItemData.speed
        relLocationList = locationList
        do {
            try managedObjectContext.save()
            print( "LocationItem: addRecord OK \(String(describing: dateCreated))" )
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }

    class func delAllRecords(entity: NSEntityDescription, managedObjectContext: NSManagedObjectContext) {
        let (_, locationItemObjs, _) = getAllRecords(entity: entity, managedObjectContext: managedObjectContext )
        for locationItemObj in locationItemObjs{
            managedObjectContext.delete(locationItemObj)
        }
        do {
            try managedObjectContext.save()
            print( "LocationItem: delAllRecords OK" )
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    class func getAllRecords(entity: NSEntityDescription, managedObjectContext: NSManagedObjectContext) -> (Bool, [LocationItem], [sLocationItemData]) {
        let locationItemFetchReq : NSFetchRequest<LocationItem> = LocationItem.fetchRequest()
        locationItemFetchReq.entity = entity
        var retBool = false
        var retObjs:[LocationItem]  = []
        var retvalues:[sLocationItemData]  = []
        
        do {
            let records = try managedObjectContext.fetch(locationItemFetchReq as! NSFetchRequest<NSFetchRequestResult>)
            print( "LocationItem: No of records \(records.count)")
            if records.count > 0{
                for index in 0...records.count-1 {
                    let locationItem = records[index] as! LocationItem
                    var value: sLocationItemData = sLocationItemData()
                    value.dateCreated    = locationItem.dateCreated
                    value.heading        = CLLocationDirection(locationItem.heading)
                    value.locationCoor2D = CLLocationCoordinate2D(latitude: locationItem.latitude, longitude: locationItem.longitude)
                    value.speed          = locationItem.speed
                    
                    print( "\(String(describing: value.dateCreated)) \(value.heading) \(value.locationCoor2D) \(value.speed))" )
                    retObjs.append(locationItem)
                    retvalues.append(value)
                }
            }
            retBool = true
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return (retBool, retObjs, retvalues)
    }
}
