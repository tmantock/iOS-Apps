//
//  ViewController.swift
//  Instagram
//
//  Created by Tevin Mantock on 11/11/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let addAvatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAvatarPhoto), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(white: 0, alpha: 0.03)
        field.font = UIFont.systemFont(ofSize: 14)
        field.borderStyle = .roundedRect
        field.placeholder = "ex: john@appleseed.com"
        field.autocapitalizationType = .none

        field.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        
        return field
    }()

    let userNameTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(white: 0, alpha: 0.03)
        field.font = UIFont.systemFont(ofSize: 14)
        field.borderStyle = .roundedRect
        field.placeholder = "User Name"
        
        field.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        
        return field
    }()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.backgroundColor = UIColor(white: 0, alpha: 0.03)
        field.font = UIFont.systemFont(ofSize: 14)
        field.borderStyle = .roundedRect
        field.placeholder = "Password"
        
        field.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        
        return field
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return button
    }()
    
    let backToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Already have an accout? ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        title.append(NSAttributedString(string: "Login", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        view.addSubview(addAvatarButton)
        addAvatarButton.anchor(top: view.topAnchor, right: nil, bottom: nil, left: nil, paddingTop: 40, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 140, width: 140)
        NSLayoutConstraint.activate([
            addAvatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        setupInputFields()
        
        view.addSubview(backToLoginButton)
        backToLoginButton.anchor(top: nil, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: -10, paddingLeft: 0, height: 50, width: 0)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text, email.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else { return }
        guard let username = userNameTextField.text, username.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else { return }
        guard let password = passwordTextField.text, password.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else { return }

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Failed to create user: ", error)
            }
            
            guard let image = self.addAvatarButton.imageView?.image else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profileImage").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if let err = err {
                    print("Failed to upload profile image ", err)
                    return
                }
                
                guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
                guard let uid = user?.uid else { return }
                
                let values = [uid: ["username": username, "profileImage": imageUrl]]
                
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, reference) in
                    if let err = err {
                        print("Failed to save user information", err)
                        return
                    }
                    
                    guard let main = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                    main.setupViewControllers()
                    self.dismiss(animated: true, completion: nil)
                })
            })
        }
    }
    
    @objc func handleInputChange() {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        let username = userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        
        if email > 0 && username > 0 && password > 0 {
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            signUpButton.isEnabled = false
        }
    }
    
    @objc func handleAvatarPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            addAvatarButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            addAvatarButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        let blue = UIColor.rgb(red: 17, green: 154, blue: 237)
        
        addAvatarButton.layer.cornerRadius = addAvatarButton.frame.width / 2
        addAvatarButton.layer.masksToBounds = true
        addAvatarButton.layer.borderColor = blue.cgColor
        addAvatarButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.anchor(top: addAvatarButton.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 20, paddingRight: -40, paddingBottom: 0, paddingLeft: 40, height: 200, width: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

