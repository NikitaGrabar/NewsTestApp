//
//  NewsModel.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation

protocol NewsModelProtocol {
    var newsModel: [ResultsNews] { get set }
    var heightRow: CGFloat {get}
}

class NewsModel: NewsModelProtocol {
 
    var newsModel: [ResultsNews] = []
    
    var heightRow: CGFloat = 110
}
