//
//  LocationList+CoreDataClass.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-05.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

import CoreData

public class LocationList: NSManagedObject {
    required public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
