//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Tevin Mantock on 11/23/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        
        setupViewControllers()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        
        if index == 2 {
            let share = ShareController(collectionViewLayout: UICollectionViewFlowLayout())
            let controller = UINavigationController(rootViewController: share)
            present(controller, animated: true, completion: nil)

            return false
        }
        
        return true
    }
    
    func setupViewControllers() {
        let layout = UICollectionViewFlowLayout()
        let home = HomeController(collectionViewLayout: layout)
        let discover = DiscoverController(collectionViewLayout: layout)
        let share = ShareController(collectionViewLayout: layout)
        let social = SocialController(collectionViewLayout: layout)
        let profile = UserProfileController(collectionViewLayout: layout)
        // Home
        let homeController = templateNavController(rootController: home, unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        // Discover
        let discoverController = templateNavController(rootController: discover, unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"))
        // Share
        let shareController = templateNavController(rootController: share, unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        // Social
        let socialController = templateNavController(rootController: social, unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        // User Profile
        let profileController = templateNavController(rootController: profile, unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"))
        
        viewControllers = [homeController, discoverController, shareController, socialController, profileController]

        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(rootController: UICollectionViewController, unselectedImage: UIImage, selectedImage: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        
        return navigationController
    }
}
