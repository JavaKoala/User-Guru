//
//  AppSetting.swift
//  User Guru
//
//  Created by Ben Meyer on 8/16/17.
//  Copyright © 2017 bpmeyer. All rights reserved.
//

import Foundation
import CoreData

class AppSetting {

    // Only requesting from one entity with this class
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppSettings")

    // Use NSPersistentContainer User_Guru
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "User_Guru")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unable to load persistent stores: \(error)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror)")
            }
        }
    }

    public func getSetting(settingName:String)->String {
        var settingValue:String = ""

        let context = persistentContainer.viewContext
        request.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let value = result.value(forKey: settingName) as? String {
                        settingValue = value
                    }
                }
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror)")
        }
        
        return settingValue
    }

    public func setSetting(settingName:String, settingValue:String) {
        let context = persistentContainer.viewContext
        request.propertiesToFetch = [settingName]
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    result.setValue(settingValue, forKey: settingName)
                }
            } else {
                let appSettings = NSEntityDescription.insertNewObject(forEntityName: "AppSettings", into: context)
                appSettings.setValue(settingValue, forKey: settingName)
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror)")
        }
        saveContext()
    }
}
