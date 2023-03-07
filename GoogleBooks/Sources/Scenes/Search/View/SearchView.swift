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
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.leftView = self.magnifyingglassStackView
        searchBar.searchTextField.font = UIFont.markProRegular(ofSize: 12)
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private lazy var searchTableView = MainTableView(frame: .zero, style: .plain)
    
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
        self.booksSearchBar.layer.cornerRadius = booksSearchBar.bounds.height / 2
    }
    
    // MARK: - Settings

    private func setupHierarchy() {
        addSubviews(booksSearchBar, searchTableView)
    }
    
    private func setupLayout() {
        booksSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(1/5)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview().inset(10)
            make.top.equalTo(booksSearchBar).offset(20)
        }
    }
    
    private func setupView() {
                
    }
}
