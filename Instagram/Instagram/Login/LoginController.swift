//
//  LoginController.swift
//  Instagram
//
//  Created by Tevin Mantock on 12/13/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, right: nil, bottom: nil, left: nil, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 50, width: 200)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        
        return view
    }()

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Don't have an accout? ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        title.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    let emailTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(white: 0, alpha: 0.03)
        field.font = UIFont.systemFont(ofSize: 14)
        field.borderStyle = .roundedRect
        field.placeholder = "ex: john@appleseed.com"
        field.autocapitalizationType = .none
        
        // field.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        
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
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview((logoContainerView))
        logoContainerView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 200, width: 0)
    
        navigationController?.isNavigationBarHidden = true
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: -10, paddingLeft: 0, height: 50, width: 0)
        setupInputFields()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func handleShowSignUp() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @objc func handleInputChange() {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        
        if email > 0 && password > 0 {
            loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            loginButton.isEnabled = false
        }
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if let err = err {
                print("Failed to login: ", err)
                return
            }
            
            guard let main = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            main.setupViewControllers()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 40, paddingRight: -40, paddingBottom: 0, paddingLeft: 40, height: 150, width: 0)
    }
}
