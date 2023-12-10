//
//  FavoritNewsView.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation
import UIKit

protocol FavoritNewsViewInput: AnyObject {
    func reloadData()
}

protocol FavoritNewsViewOutput: AnyObject {
    func numberOfRows() -> Int
    func heightofRow() -> CGFloat
    func getCellDataAt(_ indexPath: IndexPath) -> NewsRealm?
    func didSelectRowAt(_ indexPath: IndexPath)
}

class FavoritNewsView: UIView {
    
    @IBOutlet private weak var tableView: UITableView!
    
    weak var controller: FavoritNewsViewOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self)
    }
    
}

extension FavoritNewsView: FavoritNewsViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}

extension FavoritNewsView: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NewsCell
        let cellData = controller.getCellDataAt(indexPath)
        cell.dataRealm = cellData
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return controller.heightofRow()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.didSelectRowAt(indexPath)
    }
}

