//
//  SearchView.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit
import SnapKit

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
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = .gray
        searchBar.searchTextField.leftView = self.magnifyingglassStackView
        searchBar.searchTextField.font = UIFont.markProRegular(ofSize: 16)
        return searchBar
    }()
    
    private lazy var searchTableView = MainTableView(frame: .zero, style: .plain)
    private lazy var activityIndicatorView = UIActivityIndicatorView.internalActivityIndicatorViewInit()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.booksSearchBar.searchTextField.layer.cornerRadius = booksSearchBar.bounds.height / 2
    }
    
    // MARK: - Settings

    private func setupHierarchy() {
        addSubviews(booksSearchBar, activityIndicatorView, searchTableView)
    }
    
    private func setupLayout() {
        booksSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalToSuperview().dividedBy(10)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(booksSearchBar.snp.bottom).offset(20)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(activityIndicatorView.snp.top)
            make.left.equalTo(activityIndicatorView.snp.left)
            make.bottom.equalTo(activityIndicatorView.snp.bottom)
            make.right.equalTo(activityIndicatorView.snp.right)
        }
    }
    
    private func setupView() {
        activityIndicatorView.color = .gray
//        searchTableView.isHidden = true
    }
}