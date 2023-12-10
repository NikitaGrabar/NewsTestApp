//
//  FavoritNewsModel.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation

protocol FavoritNewsModelProtocol {
    var newsModel: [NewsRealm] { get set }
    var heightRow: CGFloat {get}
}

class FavoritNewsModel: FavoritNewsModelProtocol{
    
    var newsModel: [NewsRealm] = []
    
    var heightRow: CGFloat = 110
}
