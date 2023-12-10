//
//  RealmNewsPersistence.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation
import Realm
import RealmSwift

class NewsRealm: Object {
    @objc dynamic var title = ""
    @objc dynamic var descriptions = ""
    @objc dynamic var datePub = ""
    @objc dynamic var image = ""
    @objc dynamic var sourceId = ""
    @objc dynamic var link = ""
}

protocol RealmUserProtocol {
    func add(user: ResultsNews)
    func get(sourceId: String) -> NewsRealm
    func delete(sourceId: String)
}

class RealmNewsPersistence: RealmUserProtocol {
    
    static let shared = RealmNewsPersistence()
    private init() {}
    
    var userData: [NewsRealm] = []
    
    func updateDataFromStorage() {
        userData = []
        let userModelsArray = NewsDataStorage.gerArray()
        for  userModel in userModelsArray {
            userData.append(userModel)
        }
    }
    
    func add(user: ResultsNews) {
        let newUser = NewsRealm()
        newUser.title = user.title ?? ""
        newUser.descriptions = user.description ?? ""
        newUser.image = user.image_url ?? ""
        newUser.datePub = user.pubDate ?? ""
        newUser.sourceId = user.source_id ?? ""
        newUser.link = user.link ?? ""
        NewsDataStorage.add(userData: newUser)
        self.updateDataFromStorage()
    }
    
    func get(sourceId: String) -> NewsRealm {
        updateDataFromStorage()
        for item in self.userData {
            if item.sourceId == sourceId {
                return item
            }
        }
        return NewsRealm()
    }
    
    func delete(sourceId: String) {
        for item in self.userData{
            if item.sourceId == sourceId {
                NewsDataStorage.delete(userData: item)
            }
        }
        self.updateDataFromStorage()
    }
}

