//
//  NewsController.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation
import UIKit

class NewsController: UIViewController {
    
    var model: NewsModelProtocol = NewsModel()
    
    // MARK: - Pagination
    var isLoadingNewPage = false
    var loadedPages: Int = 0
    var maxPages: Int = .max
    var nextPage: String = ""
        
    private var myView: NewsViewInput! {
        self.view as? NewsViewInput
    }
    
    override func loadView() {
        let view: NewsView = NewsView.fromNib()
        view.controller = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        getNews("")
    }
    // чуть не правильно сделал,мог бы и проще,но пришлось считать в ручную количество страниц
    
    private func getNews(_ page: String) {
        isLoadingNewPage = true
        NetworkManager.shared.getNews(page: page, onSuccess: { data in
            DispatchQueue.main.async {
                ActivityLoader.shared.hide()
                self.nextPage = data.nextPage ?? ""
                let pageDouble: Double = Double((data.totalResults ?? 0)) / 10
                let remainder = pageDouble.truncatingRemainder(dividingBy: 1)
                if remainder == 0 {
                    self.maxPages = Int(pageDouble)
                } else {
                    self.maxPages = Int(pageDouble) + 1
                }
                if page.isEmpty {
                    self.loadedPages = 1
                    self.model.newsModel = data.results ?? []
                }
                else {
                    self.loadedPages += 1
                    self.model.newsModel += data.results ?? []
                }
                self.isLoadingNewPage = false
                self.myView.reloadWithRefresh()
            }
        }, onFailure: {
            DispatchQueue.main.async {
                ActivityLoader.shared.hide()
                self.isLoadingNewPage = false
                print("error")
            }
        })
    }
    
    private func setupNavBar() {
        createGradientForNavigationBar()
    }
}

extension NewsController: NewsViewOutput {
    func reload() {
        model.newsModel = []
        myView.reloadData()
        getNews("")
    }
    
    
    func numberOfRows() -> Int {
        return model.newsModel.count
    }
    
    func getCellDataAt(_ indexPath: IndexPath) -> ResultsNews? {
        return model.newsModel[indexPath.row]
    }
    
    func heightofRow() -> CGFloat {
        return model.heightRow
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let vc = NewsDetailController()
        vc.model.newsModel = model.newsModel[indexPath.row]
        vc.model.state = .data
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkIfNeedToLoadNewPage(for index: Int) -> Bool {
        let offset: Int = 3
        let numberOfLoadedPages = loadedPages
        guard !isLoadingNewPage, numberOfLoadedPages < maxPages, index >= model.newsModel.count - offset else {
            return false
        }
        isLoadingNewPage = true
        getNews(nextPage)
        return true
    }
}
