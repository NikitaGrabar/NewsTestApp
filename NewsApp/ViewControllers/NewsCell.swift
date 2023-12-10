//
//  NewsCell.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var data: ResultsNews? {didSet {setup()}}
    var dataRealm: NewsRealm? {didSet {setupRealm()}}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup () {
        guard let data = data else {return}
        title.text = data.title
        descriptionLabel.text = data.description
        dateLabel.text = data.pubDate
        if let imageUrl = data.image_url {
            NetworkManager.shared.getImage(urlString: imageUrl) { imageData in
                DispatchQueue.main.async {
                    guard
                        let data = imageData,
                        let image = UIImage(data: data)
                    else {return}
                    self.newsImage.image = image
                    self.newsImage.contentMode = .scaleAspectFit
                }
            }
        } else {
            newsImage.image = UIImage(named: "default_image")
        }
    }
    
    func setupRealm () {
        guard let data = dataRealm else {return}
        title.text = data.title
        descriptionLabel.text = data.descriptions
        dateLabel.text = data.datePub
        if data.image != "default_image" {
            NetworkManager.shared.getImage(urlString: data.image) { imageData in
                DispatchQueue.main.async {
                    guard
                        let data = imageData,
                        let image = UIImage(data: data)
                    else {return}
                    self.newsImage.image = image
                    self.newsImage.contentMode = .scaleAspectFit
                }
            }
        } else {
            newsImage.image = UIImage(named: "default_image")
        }
    }

}
