//
//  ViewController.swift
//  Flash Chat
//
//  Created by Tevin Mantock on 12/28/2017.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    let messageReference = "messages"
    var messages : [Message] = [Message]()

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)

        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        retrieveMessages()

        messageTableView.separatorStyle = .none
    }

    //MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        let message = messages[indexPath.row]
        cell.messageBody.text = message.message
        cell.senderUsername.text = message.sender
        cell.avatarImageView.image = UIImage(named: "egg")
        cell.avatarImageView.backgroundColor = .white

        if message.sender == Auth.auth().currentUser?.email {
            cell.backgroundColor = UIColor.flatBlue()
        } else {
            cell.backgroundColor = UIColor.flatGray()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }

    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }

    //MARK:- TextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }

    //MARK: - Send & Recieve from Firebase
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        sendButton.isEnabled = false
        messageTextfield.isEnabled = false
        
        guard let valueText = messageTextfield.text else { return }
        let value = valueText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if value.count == 0 {
            return
        }

        let messages = Database.database().reference().child(messageReference)
        let dict = ["sender": Auth.auth().currentUser?.email, "message" : value]
        messages.childByAutoId().setValue(dict) {
            (error, reference) in
            if let error = error {
                print(error)
                
                return
            }
            
            self.messageTextfield.text = ""
            self.messageTextfield.isEnabled = true
            self.sendButton.isEnabled = true
        }
    }

    func retrieveMessages() {
        let messages = Database.database().reference().child(messageReference)
        messages.observe(.childAdded) { (snapshot) in
            let value = snapshot.value as! Dictionary<String, String>
            guard let sender = value["sender"] else { return }
            guard let message = value["message"] else { return }

            let model = Message(sender: sender, message: message)
            self.messages.append(model)
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }

    @IBAction func logOutPressed(_ sender: AnyObject) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Error signing out")
        }
    }
}
