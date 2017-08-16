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

    let settings = AppSetting()

    @IBOutlet weak var websiteTextField: UITextField!

    @IBOutlet weak var userEmailTextField: UITextField!

    @IBOutlet weak var userMessage: UILabel!
    
    @IBAction func loginButton(_ sender: Any) {
        if let userWebsite = websiteTextField.text {
            print (userWebsite)
        }
    }

    @IBAction func signUpButton(_ sender: Any) {

        if websiteTextField.hasText && userEmailTextField.hasText {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppSettings")
            request.returnsObjectsAsFaults = false

            // If the app settings exist update them
            // If the app settings do not exist then create them
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if (result.value(forKey: "website") as? String) != nil {
                            if let websiteURL = websiteTextField.text {
                                result.setValue(websiteURL, forKey: "website")
                            }
                        }
                        if (result.value(forKey: "userEmail") as? String) != nil {
                            if let userEmail = userEmailTextField.text {
                                result.setValue(userEmail, forKey: "userEmail")
                            }
                        }
                    }
                } else {
                    let appSettings = NSEntityDescription.insertNewObject(forEntityName: "AppSettings", into: context)
                    if let websiteURL = websiteTextField.text {
                        appSettings.setValue(websiteURL, forKey: "website")
                    }
                    if let userEmail = userEmailTextField.text {
                        appSettings.setValue(userEmail, forKey: "userEmail")
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
        } else {
            userMessage.text = "Please enter a website, email, and password."
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websiteTextField.text = settings.getWebsite()
        userEmailTextField.text = settings.getUserEmail()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

