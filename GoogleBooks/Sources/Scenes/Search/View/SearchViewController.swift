//
//  SearchViewController.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Infrastructure
    
    private lazy var searchView: SearchView = {
        let searchView = SearchView(frame:.zero)
        return searchView
    }()
    
    var presenter: SearchPresenterProtocol? = nil
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [unowned self] in
            searchView.searchTableView.reloadData()
        }
    }
    
    // MARK: - Settings
    
    private func setupView() {
        self.view.backgroundColor = .white
        searchView.fillSuperview()
        searchView.show(next: .placeholderLabel)
        searchView.searchTableView.dataSource = self
        searchView.searchBarDelegate(on: self)
    }
}


// MARK: - Extensions -

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.reuseID,
            for: indexPath
        )
                as? MainTableViewCell else { return UITableViewCell() }
        
        guard let items = presenter?.model?.items else { fatalError() }
        let item = items[indexPath.row]
        
        cell.recieveItem(item: item)
        presenter?.networkService.loadingImageData(
            imageURL: URL(string: item.volumeInfo.imageLinks?.thumbnail ?? ""),
            completion: cell.cellImageConfiguration())
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - Extensions

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty == false
        else {
            searchView.show(next: .placeholderLabel)
            return
        }
        searchView.show(next: .activityIndicator)
        presenter?.fetchSearchingData(by: searchText)
    }
}

extension SearchViewController: SearchViewProtocol {
    func show(next view: SearchView.ShowConfiguration) {
        searchView.show(next: view)
        if view == .tableView {
            let group = DispatchGroup()
            group.enter()
            searchView.searchTableView.reloadData {
                group.leave()
            }
            group.notify(queue: .main) { [unowned self] in
                searchView.searchTableView.scroll(to: .top, animated: true)
            }
        }
    }
}
