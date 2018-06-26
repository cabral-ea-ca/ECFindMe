//
//  LocationList+CoreDataProperties.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-05.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

import CoreData

extension LocationList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationList> {
        return NSFetchRequest<LocationList>(entityName: "LocationList")
    }

    @NSManaged internal var dateCreated: NSDate?
    @NSManaged internal var relLocationItems: NSSet?
    
    class func getRecord(entity: NSEntityDescription, managedObjectContext: NSManagedObjectContext) -> LocationList? {
        let appSettingsFetchReq : NSFetchRequest<LocationList> = LocationList.fetchRequest()
        appSettingsFetchReq.entity = entity
        var retLocationList : LocationList?
        do {
            let records = try managedObjectContext.fetch(appSettingsFetchReq as! NSFetchRequest<NSFetchRequestResult>)
            print( "LocationList: No of records \(records.count)")
            
            if (records.count == 1 ) {
                let locationList = records[0] as! LocationList
                print( "\(String(describing: locationList.dateCreated))" )
                retLocationList = locationList
            }
            else{
                print( "LocationList: Why has \(records.count) records" )
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return retLocationList
    }
    
    func saveRecord( managedObjectContext: NSManagedObjectContext ){
        dateCreated = NSDate()
        do {
            try managedObjectContext.save()
            print( "LocationList: saveValues OK" )
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
}

// MARK: Generated accessors for relLocationItems
extension LocationList {

    @objc(addRelLocationItemsObject:)
    @NSManaged public func addToRelLocationItems(_ value: LocationItem)

    @objc(removeRelLocationItemsObject:)
    @NSManaged public func removeFromRelLocationItems(_ value: LocationItem)

    @objc(addRelLocationItems:)
    @NSManaged public func addToRelLocationItems(_ values: NSSet)

    @objc(removeRelLocationItems:)
    @NSManaged public func removeFromRelLocationItems(_ values: NSSet)

}
