//
//  NewsDataStorage.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import RealmSwift
import Foundation

fileprivate let RealmQueueName = "com.appy.realm.thread.conccurent"

class QueueManager {
    static let realmQueue = DispatchQueue(label: RealmQueueName,
                                          qos: .userInteractive,
                                          attributes: .concurrent)
}


class NewsDataStorage: NSObject {
    
    static func gerArray() -> [NewsRealm] {
        QueueManager.realmQueue.sync {
            let realm = try! Realm()
            return Array(realm.objects(NewsRealm.self))
        }
    }
    
    static func add(userData: NewsRealm) {
        QueueManager.realmQueue.sync {
            let realm = try! Realm()
            
            try! realm.safeWrite {
                realm.add(userData)
            }
        }
    }
    
    static func delete(userData: NewsRealm) {
        QueueManager.realmQueue.sync {
            let realm = try! Realm()
            
            try! realm.safeWrite {
                realm.delete(userData)
            }
        }
    }
    
}

extension Realm {
    
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}


