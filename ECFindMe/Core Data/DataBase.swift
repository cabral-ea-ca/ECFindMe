//
//  DataBase.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-05.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import CoreData

class DataBase{
    var coreDataManager: CoreDataManager = CoreDataManager(modelName: "DataModel")
    var managedObjectContext: NSManagedObjectContext?
    var entityAppSettings: NSEntityDescription?
    var entityLocationItem: NSEntityDescription?
    var entityLocationList: NSEntityDescription?
    var locationList: LocationList?

    init(){
        managedObjectContext = coreDataManager.managedObjectContext
        entityAppSettings  = coreDataManager.entityDesc(entityName: "AppSettings", managedObjectContext: managedObjectContext!)
        entityLocationItem = coreDataManager.entityDesc(entityName: "LocationItem", managedObjectContext: managedObjectContext!)
        entityLocationList = coreDataManager.entityDesc(entityName: "LocationList", managedObjectContext: managedObjectContext!)
        locationList = LocationList.getRecord( entity: entityLocationList!, managedObjectContext: managedObjectContext! )
        if locationList == nil{
            locationList = coreDataManager.managedObj(entityName: "LocationList", managedObjectContext: managedObjectContext!)
            locationList?.saveRecord(managedObjectContext: managedObjectContext!)
            _ = LocationList.getRecord( entity: entityLocationList!, managedObjectContext: managedObjectContext! )
        }
        _ = getLocationItems()
    }
    
    func getAppSettings() -> (Bool, AppSettings.sAppSettingsData){
        let (retBool, _, appSetingsData) = AppSettings.getRecord( entity: entityAppSettings!, managedObjectContext: managedObjectContext! )
        return(retBool, appSetingsData)
    }
    
    func saveAppSettings( appSettingsData: AppSettings.sAppSettingsData) -> (Bool){
        let (retBool, appSetings, _) = AppSettings.getRecord( entity: entityAppSettings!, managedObjectContext: managedObjectContext! )
        var appSettingsObj: AppSettings?
        if retBool == false {
            appSettingsObj = coreDataManager.managedObj(entityName: "AppSettings", managedObjectContext: managedObjectContext!)
        }
        else{
            appSettingsObj = appSetings
        }
        appSettingsObj?.saveRecord(appSettingsData: appSettingsData, managedObjectContext: managedObjectContext!)
        
        return (retBool)
    }
    
    func addLocationItem(locationItemData: LocationItem.sLocationItemData){
        let locationItem: LocationItem? = coreDataManager.managedObj(entityName: "LocationItem", managedObjectContext: managedObjectContext!)
        locationItem?.addRecord(locationItemData: locationItemData, locationList: locationList!, managedObjectContext: managedObjectContext!)
    }
    
    func delLocationItems(){
        LocationItem.delAllRecords(entity: entityLocationItem!, managedObjectContext: managedObjectContext!)
    }

    func getLocationItems() -> (Bool, [LocationItem.sLocationItemData]){
        let (retBool, _, locationItemData) = LocationItem.getAllRecords(entity: entityLocationItem!, managedObjectContext: managedObjectContext!)
        
        return (retBool, locationItemData)
    }
    
}
