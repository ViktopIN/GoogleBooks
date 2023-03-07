//
//  SearchView.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

class SearchView: UIView {
    
    // MARK: - Views
    
    private lazy var magnifyingglassStackView: UIStackView = {
        let stackView = UIStackView(with: .horizontal,
                                    distribution: .fillEqually)
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(.customOrange,
                                                                          renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        let leftView = UIView(background: .clear)
        let rightView = UIView(background: .clear)
        stackView.addArrangedSubviews(leftView, imageView, rightView)
        return stackView
    }()

    private lazy var booksSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.leftView = self.magnifyingglassStackView
        searchBar.searchTextField.font = UIFont.markProRegular(ofSize: 12)
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
}
