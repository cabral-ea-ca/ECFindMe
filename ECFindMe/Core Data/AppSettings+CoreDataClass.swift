//
//  AppSettings+CoreDataClass.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-05.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

import CoreData
import CoreLocation
import MapKit

public class AppSettings: NSManagedObject {
    struct sAppSettingsData{
        var locationCoor2D = CLLocationCoordinate2D(latitude: +43.653908, longitude: -79.384293)
        var regionSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }

    required public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
