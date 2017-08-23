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

    @IBOutlet weak var userNameTextField: UITextField!

    @IBOutlet weak var userEmailTextField: UITextField!

    @IBOutlet weak var userMessage: UILabel!
    
    @IBAction func loginButton(_ sender: Any) {
        if let userWebsite = websiteTextField.text {
            print (userWebsite)
        }
    }

    @IBAction func signUpButton(_ sender: Any) {

        if websiteTextField.hasText && userNameTextField.hasText && userEmailTextField.hasText {
            let settings = AppSetting()
            settings.setSetting(settingName: "website", settingValue: websiteTextField.text!)
            settings.setSetting(settingName: "userName", settingValue: userNameTextField.text!)
            settings.setSetting(settingName: "userEmail", settingValue: userEmailTextField.text!)
        } else {
            userMessage.text = "Please enter a website, user name and email"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let settings = AppSetting()

        if settings.getSetting(settingName: "website") != "" {
            websiteTextField.text = settings.getSetting(settingName: "website")
        }
        
        if settings.getSetting(settingName: "userName") != "" {
            userNameTextField.text = settings.getSetting(settingName: "userName")
        }

        if settings.getSetting(settingName: "userEmail") != "" {
            userEmailTextField.text = settings.getSetting(settingName: "userEmail")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

