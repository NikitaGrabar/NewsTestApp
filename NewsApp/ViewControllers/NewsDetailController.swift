//
//  NewsDetailController.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation
import UIKit
protocol RemoveDelegate: AnyObject {
    func updateState()
}

class NewsDetailController: UIViewController {
    
    var model: NewsDetailModelProtocol = NewsDetailModel()
    weak var removeDelegate: RemoveDelegate?
        
    private var myView: NewsDetailViewInput! {
        self.view as? NewsDetailViewInput
    }
    
    override func loadView() {
        let view: NewsDetailView = NewsDetailView.fromNib()
        view.controller = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkState()
        setupNavBar()
    }
    
    func checkState() {
        if model.newsModel != nil {
            model.state = .data
            myView.setupView(data: model.newsModel)
        } else {
            model.state = .realmData
            myView.setupViewRealm(data: model.newsModelRealm)
        }
    }
    
    func checkFavorit() -> UIImage {
        if model.state == .data {
            guard let newsModel = model.newsModel else {return UIImage()}
            let realmModel = RealmNewsPersistence.shared.get(sourceId: newsModel.source_id ?? "")
            if realmModel.sourceId == newsModel.source_id {
                model.favorit = true
                return UIImage(systemName: "star.circle.fill")!
            } else {
                model.favorit = false
                return UIImage(systemName: "star.circle")!
            }
        } else {
            guard let newsModel = model.newsModelRealm else {return UIImage()}
            let realmModel = RealmNewsPersistence.shared.get(sourceId: newsModel.sourceId)
            if realmModel.sourceId == newsModel.sourceId {
                model.favorit = true
                return UIImage(systemName: "star.circle.fill")!
            } else {
                model.favorit = false
                return UIImage(systemName: "star.circle")!
            }
        }
    }
    
    private func setupNavBar() {
        createGradientForNavigationBar()
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(handleBackNavigationButton))
        self.navigationItem.leftBarButtonItem = backButton
        let favoritBtn = UIBarButtonItem(image: checkFavorit(), style: .plain, target: self, action: #selector(tapFavorit))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem = favoritBtn
    }

    @objc private func handleBackNavigationButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapFavorit() {
        if model.state == .data {
            guard let data = model.newsModel else {return}
            model.favorit == true ? RealmNewsPersistence.shared.delete(sourceId: data.source_id ?? "") : RealmNewsPersistence.shared.add(user: data)
            model.favorit.toggle()
            setupNavBar()
        } else {
            guard let data = model.newsModelRealm else {return}
            RealmNewsPersistence.shared.delete(sourceId: data.sourceId)
            self.removeDelegate?.updateState()
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension NewsDetailController: NewsDetailViewOutput {
    
}
