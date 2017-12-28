//
//  UserProfileHeader.swift
//  Instagram
//
//  Created by Tevin Mantock on 12/10/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import UIKit

class UserProfileHeader : UICollectionViewCell{
    var user: User? {
        didSet {
            setupProfileImage()
            usernameLabel.text = user?.username
        }
    }

    let profileImageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    let gridButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        text.append(NSAttributedString(string: "Posts", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = text
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        text.append(NSAttributedString(string: "Followers", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = text
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        text.append(NSAttributedString(string: "Following", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = text
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 12, paddingRight: 0, paddingBottom: 0, paddingLeft: 12, height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupToolBar()
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, right: rightAnchor, bottom: listButton.topAnchor, left: leftAnchor, paddingTop: 4, paddingRight: 12, paddingBottom: 0, paddingLeft: 12, height: 0, width: 0)
        
        setupUserStats()
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postLabel.bottomAnchor, right: followingLabel.rightAnchor, bottom: nil, left: postLabel.leftAnchor, paddingTop: 2, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 34, width: 0)
    }
    
    fileprivate func setupProfileImage() {
        guard let imageURL = user?.profileImageUrl else { return }
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print(err)
                return
            }

            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
    }
    
    fileprivate func setupToolBar() {
        let topDivider = UIView()
        let bottomDivider = UIView()
        
        topDivider.backgroundColor = UIColor.lightGray
        bottomDivider.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [listButton, gridButton, bookmarkButton])
        addSubview(stackView)
        
        stackView.distribution = .fillEqually
        
        stackView.anchor(top: nil, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 50, width: 0)
        
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        topDivider.anchor(top: stackView.topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 0.5, width: 0)
        bottomDivider.anchor(top: nil, right: rightAnchor, bottom: stackView.bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 0.5, width: 0)
    }
    
    fileprivate func setupUserStats() {
        let stackView = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor, right: rightAnchor, bottom: nil, left: profileImageView.rightAnchor, paddingTop: 12, paddingRight: 12, paddingBottom: 0, paddingLeft: 12, height: 50, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
