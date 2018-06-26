//
//  LocationItem+CoreDataClass.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-05.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

import CoreData
import CoreLocation

public class LocationItem: NSManagedObject {
    struct sLocationItemData{
        var dateCreated: NSDate?
        var heading        = CLLocationDirection()
        var locationCoor2D = CLLocationCoordinate2D(latitude: +43.653908, longitude: -79.384293)
        var speed:Int16    = 0
    }
    
    required public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
