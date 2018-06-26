//
//  CoreDataManagerExt.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-05.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import CoreData

extension CoreDataManager{
    func entityDesc(entityName: String, managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
        if entity != nil {
            print ( "Entity \(entityName) created" )
        }
        else{
            print ( "Entity \(entityName) cannot create" )
        }
        
        return entity
    }
    
    func managedObj<T>(entityName: String, managedObjectContext: NSManagedObjectContext) -> T? where T:AppSettings  {
        let entity =  entityDesc(entityName: entityName, managedObjectContext: managedObjectContext)
        
        if let entity = entity {
            print ( "AppSettings managedObj created" )
            let managedObj:T = T(entity: entity, insertInto: managedObjectContext)
            return managedObj
        }
        else{
            print ( "AppSettings managedObj cannot create" )
            return nil
        }
    }
    
    func managedObj<T>(entityName: String, managedObjectContext: NSManagedObjectContext) -> T? where T:LocationItem  {
        let entity =  entityDesc(entityName: entityName, managedObjectContext: managedObjectContext)
        
        if let entity = entity {
            print ( "LocationItem managedObj created" )
            let managedObj:T = T(entity: entity, insertInto: managedObjectContext)
            return managedObj
        }
        else{
            print ( "LocationItem managedObj cannot create" )
            return nil
        }
    }
    
    func managedObj<T>(entityName: String, managedObjectContext: NSManagedObjectContext) -> T? where T:LocationList {
        let entity =  entityDesc(entityName: entityName, managedObjectContext: managedObjectContext)
        
        if let entity = entity {
            print ( "LocationList managedObj created" )
            let managedObj:T = T(entity: entity, insertInto: managedObjectContext)
            return managedObj
        }
        else{
            print ( "LocationList managedObj cannot create" )
            return nil
        }
    }
}
