//
//  FavoritNewsController.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation
import UIKit

class FavoritNewsController: UIViewController {
    
    var model: FavoritNewsModelProtocol = FavoritNewsModel()

    private var myView: FavoritNewsViewInput! {
        self.view as? FavoritNewsViewInput
    }

    override func loadView() {
        let view: FavoritNewsView = FavoritNewsView.fromNib()
        view.controller = self
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNewsRealm()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getNewsRealm() {
        model.newsModel = RealmNewsPersistence.shared.userData
        myView.reloadData()
    }
}

extension FavoritNewsController: FavoritNewsViewOutput {
    
    func numberOfRows() -> Int {
        return model.newsModel.count
    }
    
    func getCellDataAt(_ indexPath: IndexPath) -> NewsRealm? {
        return model.newsModel[indexPath.row]
    }
    
    func heightofRow() -> CGFloat {
        return model.heightRow
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let vc = NewsDetailController()
        vc.model.newsModelRealm = model.newsModel[indexPath.row]
        vc.model.state = .realmData
        vc.removeDelegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoritNewsController: RemoveDelegate {
    func updateState() {
        getNewsRealm()
    }
}

