//
//  UIViewController.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import UIKit

extension UIViewController {
    
    func createGradientForNavigationBar() {
        guard
            let navigationController = self.navigationController,
            let flareGradientImage = CAGradientLayer.primaryGradient(on: navigationController.navigationBar)
        else {
            print("Error creating gradient color!")
            return
        }
        navigationController.navigationBar.barTintColor = UIColor(patternImage: flareGradientImage)
    }
}
