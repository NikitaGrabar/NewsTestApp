//
//  NewsView.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation
import UIKit

protocol NewsViewInput: AnyObject {
    func reloadData()
    func reloadWithRefresh()
}

protocol NewsViewOutput: AnyObject {
    func numberOfRows() -> Int
    func heightofRow() -> CGFloat
    func getCellDataAt(_ indexPath: IndexPath) -> ResultsNews?
    func didSelectRowAt(_ indexPath: IndexPath)
    func reload()
    func checkIfNeedToLoadNewPage(for index: Int) -> Bool
}

class NewsView: UIView {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let refreshControl: UIRefreshControl  = {
        let refreshcontroller = UIRefreshControl()
        refreshcontroller.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshcontroller
    }()
    
    weak var controller: NewsViewOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        controller.reload()
    }
    
    func paginationConfigure(index: Int) {
        guard controller.checkIfNeedToLoadNewPage(for: index) else { return }
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
    }
    
}

extension NewsView: NewsViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func reloadWithRefresh() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.tableView.reloadData()
            }
            return
        }
        self.tableView.reloadData()
        self.tableView.tableFooterView = nil
    }
}

extension NewsView: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NewsCell
        let cellData = controller.getCellDataAt(indexPath)
        cell.data = cellData
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return controller.heightofRow()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.didSelectRowAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        paginationConfigure(index: indexPath.row)
    }
}
