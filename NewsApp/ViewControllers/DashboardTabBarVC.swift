//
//  DashboardTabBarVC.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import UIKit


class DashboardTabBarVC: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RealmNewsPersistence.shared.updateDataFromStorage()
        setupControllers()
    }
    
    func setupControllers() {

        let newsNavBar = createNavController(for: NewsController(),
                                            title: "News",
                                            image: UIImage(systemName: "newspaper")!,
                                            selectedImage: (UIImage(systemName: "newspaper.fill"))!)
        let favoritesNavBar = createNavController(for: FavoritNewsController(),
                                              title: "Favorit News",
                                              image: UIImage(systemName: "star")!,
                                              selectedImage: (UIImage(systemName: "star.fill"))!)
        
        let controllers: [UIViewController] = [newsNavBar, favoritesNavBar]
        self.viewControllers = controllers
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.tabBarItem.image?.withTintColor(.black)
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.selectedImage?.withTintColor(.black)
        navController.navigationBar.barTintColor = .black
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
