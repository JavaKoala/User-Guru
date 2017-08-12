//
//  ViewController.swift
//  User Guru
//
//  Created by Ben Meyer on 8/3/17.
//  Copyright © 2017 bpmeyer. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var websiteTextField: UITextField!

    @IBAction func loginButton(_ sender: Any) {
        if let userWebsite = websiteTextField.text {
            print (userWebsite)
        }
    }

    @IBAction func signUpButton(_ sender: Any) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppSettings")
        request.returnsObjectsAsFaults = false

        // If the app settings exist update them
        // If the app settings do not exist then create them
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                print(results)
                // To Do: Update AppSettings
            } else {
                let appSettings = NSEntityDescription.insertNewObject(forEntityName: "AppSettings", into: context)
                if let websiteURL = websiteTextField.text {
                    appSettings.setValue(websiteURL, forKey: "website")
                }
            }
        } catch {
            // To Do: Handle Errors
        }

        do {
            try context.save()
        } catch {
            // To Do: Handle Errors
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // If the website and email address are in the database, populate them
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppSettings")
        request.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let websiteURL = result.value(forKey: "website") as? String {
                        websiteTextField.text = websiteURL
                    }
                }
            }
        } catch {
            // To Do: Handle Errors
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

