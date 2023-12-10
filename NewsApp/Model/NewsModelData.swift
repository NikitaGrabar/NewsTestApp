//
//  NewsModel.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation

struct ResponseDataNews : Codable {
    let status : String?
    let totalResults : Int?
    let results : [ResultsNews]?
    let nextPage : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case totalResults = "totalResults"
        case results = "results"
        case nextPage = "nextPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        results = try values.decodeIfPresent([ResultsNews].self, forKey: .results)
        nextPage = try values.decodeIfPresent(String.self, forKey: .nextPage)
    }
}

struct ResultsNews : Codable {
    let article_id : String?
    let title : String?
    let link : String?
    let keywords : [String]?
    let creator : [String]?
    let video_url : String?
    let description : String?
    let content : String?
    let pubDate : String?
    let image_url : String?
    let source_id : String?
    let source_priority : Int?
    let country : [String]?
    let category : [String]?
    let language : String?

    enum CodingKeys: String, CodingKey {

        case article_id = "article_id"
        case title = "title"
        case link = "link"
        case keywords = "keywords"
        case creator = "creator"
        case video_url = "video_url"
        case description = "description"
        case content = "content"
        case pubDate = "pubDate"
        case image_url = "image_url"
        case source_id = "source_id"
        case source_priority = "source_priority"
        case country = "country"
        case category = "category"
        case language = "language"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        article_id = try values.decodeIfPresent(String.self, forKey: .article_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        keywords = try values.decodeIfPresent([String].self, forKey: .keywords)
        creator = try values.decodeIfPresent([String].self, forKey: .creator)
        video_url = try values.decodeIfPresent(String.self, forKey: .video_url)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        pubDate = try values.decodeIfPresent(String.self, forKey: .pubDate)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        source_id = try values.decodeIfPresent(String.self, forKey: .source_id)
        source_priority = try values.decodeIfPresent(Int.self, forKey: .source_priority)
        country = try values.decodeIfPresent([String].self, forKey: .country)
        category = try values.decodeIfPresent([String].self, forKey: .category)
        language = try values.decodeIfPresent(String.self, forKey: .language)
    }


}


