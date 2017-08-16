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

    public func getWebsite()->String {
        var website:String = ""

        let context = persistentContainer.viewContext
        request.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let websiteURL = result.value(forKey: "website") as? String {
                        website = websiteURL
                    }
                }
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror)")
        }

        return website
    }

    public func getUserEmail()->String {
        var email:String = ""

        let context = persistentContainer.viewContext
        request.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let userEmail = result.value(forKey: "userEmail") as? String {
                        email = userEmail
                    }
                }
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror)")
        }
        
        return email
    }
}
