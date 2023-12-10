//
//  Activity.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation
import SVProgressHUD

class ActivityLoader {
    
    static let shared = ActivityLoader()
    private init() { }
    
    func show() {
        SVProgressHUD.show()
    }
    
    func hide() {
        SVProgressHUD.dismiss()
    }
}
