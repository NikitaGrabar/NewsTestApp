//
//  NewsDetailView.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import UIKit

protocol NewsDetailViewInput: AnyObject {
    func setupView(data: ResultsNews?)
    func setupViewRealm(data: NewsRealm?)
}

protocol NewsDetailViewOutput: AnyObject {
    
}

class NewsDetailView: UIView {
    
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var linkLabel: UILabel!
    
    weak var controller: NewsDetailViewOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension NewsDetailView: NewsDetailViewInput {
    func setupView(data: ResultsNews?) {
        guard let news = data else {return}
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        linkLabel.text = news.link
        if let imageUrl = news.image_url {
            NetworkManager.shared.getImage(urlString: imageUrl) { imageData in
                DispatchQueue.main.async {
                    guard
                        let data = imageData,
                        let image = UIImage(data: data)
                    else {return}
                    self.newsImage.image = image
                    self.newsImage.contentMode = .scaleAspectFill
                }
            }
        } else {
            newsImage.image = UIImage(named: "default_image")
        }
    }
    
    func setupViewRealm(data: NewsRealm?) {
        guard let news = data else {return}
        titleLabel.text = news.title
        descriptionLabel.text = news.descriptions
        linkLabel.text = news.link
        if !news.image.isEmpty {
            NetworkManager.shared.getImage(urlString: news.image) { imageData in
                DispatchQueue.main.async {
                    guard
                        let data = imageData,
                        let image = UIImage(data: data)
                    else {return}
                    self.newsImage.image = image
                    self.newsImage.contentMode = .scaleAspectFill
                }
            }
        } else {
            newsImage.image = UIImage(named: "default_image")
        }
    }
    
}
