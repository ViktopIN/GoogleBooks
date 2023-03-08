//
//  FavoriteView.swift
//  GoogleBooks
//
//  Created by Виктор on 08.03.2023.
//

import SnapKit

class FavoriteView: UIView {
    
    enum ShowConfiguration {
        case placeholderLabel
        case tableView
    }
    
    private lazy var favoritesTableView: MainTableView = {
        let tableView = MainTableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    private lazy var placeholderLabel = UILabel(
        constant: "Favorite list is empty",
        with: 15,
        and: .medium,
        .lightGray
    )
    
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
        DispatchQueue.main.async { [unowned self] in
            favoritesTableView.rowHeight = favoritesTableView.bounds.height / 4
        }
    }

    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubviews(placeholderLabel, favoritesTableView)
    }
    
    private func setupLayout() {
        placeholderLabel.fillSuperview()
        favoritesTableView.snp.makeConstraints { make in
            make.top.equalTo(placeholderLabel.snp.top)
            make.left.equalTo(placeholderLabel.snp.left)
            make.size.equalTo(placeholderLabel.snp.size)
        }
    }
    
    private func setupView() {
        placeholderLabel.textAlignment = .center
        favoritesTableView.backgroundColor = .clear
    }
    
    // MARK: - Methods
    
    func show(next configuration: ShowConfiguration) {
        switch configuration {
        case .placeholderLabel:
            placeholderLabel.isHidden = false
            favoritesTableView.isHidden = true
        case .tableView:
            placeholderLabel.isHidden = true
            favoritesTableView.isHidden = false
        }
    }

    func favoritesTableViewDataSource(on container: UITableViewDataSource) {
        favoritesTableView.dataSource = container
    }
        
    func reloadTableView() {
        DispatchQueue.main.async { [unowned self] in
            favoritesTableView.reloadData()
        }
    }
}
