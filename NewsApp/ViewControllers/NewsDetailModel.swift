//
//  NewsDetailModel.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation

enum StateData {
    case realmData,data
}

protocol NewsDetailModelProtocol {
    var newsModel: ResultsNews? { get set }
    var newsModelRealm: NewsRealm? {get set}
    var state: StateData {get set}
    var favorit: Bool {get set}
}

class NewsDetailModel: NewsDetailModelProtocol {
    var state: StateData = .data
    var newsModel: ResultsNews?
    var newsModelRealm: NewsRealm?
    var favorit: Bool = false
}
