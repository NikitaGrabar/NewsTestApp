//
//  UIView.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import UIKit

extension UIView {
    
    static func fromNib<T: UIView>() -> T {
        let nibArray = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)
        return nibArray![0] as! T
    }
}

extension CAGradientLayer {

    class func primaryGradient(on view: UIView) -> UIImage? {
        let gradient = CAGradientLayer()
        var bounds = view.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.gray.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient.createGradientImage(on: view)
    }

    private func createGradientImage(on view: UIView) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}
