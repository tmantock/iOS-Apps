//
//  UserProfileController.swift
//  Instagram
//
//  Created by Tevin Mantock on 11/23/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import Firebase

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dict: [String: Any]) {
        self.username = dict["username"] as? String ?? "username"
        self.profileImageUrl = dict["profileImage"] as? String ?? ""
    }
}

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var user: User?
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        
        navigationItem.title = "User Profile"
        
        fetchUser()
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupSettingsIcon()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .purple
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        header.user = self.user
    
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    @objc func handleLogout() {
        let alertConntroller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertConntroller.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                let loginController = LoginController()
                let navigationController = UINavigationController(rootViewController: loginController)
                self.present(navigationController, animated: true, completion: nil)
            } catch let error {
                print("Error occurred during sign out", error)
            }
        }))
        
        alertConntroller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertConntroller, animated: true, completion: nil)
    }
    
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dict = snapshot.value as? [String: Any] else { return }
            
            self.user = User(dict: dict)
            
            self.navigationItem.title = self.user?.username
            
            self.collectionView?.reloadData()
        }, withCancel: {(error) in
            print(error)
        })
    }
    
    fileprivate func setupSettingsIcon() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
    }
}
