//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login
//
//  Created by Tevin Mantock on 12/28/2017.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class LogInViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.flatRed()
        navigationController?.navigationBar.barTintColor = UIColor.flatBlack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logInPressed(_ sender: AnyObject) {
        guard let emailField = emailTextfield.text else { return }
        guard let passwordField = passwordTextfield.text else { return }
        
        let email = emailField.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email.count == 0 || password.count == 0 {
            return
        }

        SVProgressHUD.show()

        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Failed with: ", error)

                return
            }

            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
    }
}  
