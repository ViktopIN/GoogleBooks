//
//  FavoriteViewController.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var presenter: FavoritePresenterProtocol! = nil
    
    private var favoriteView: FavoriteView = {
        let view = FavoriteView(frame: .zero)
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = favoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewWillAppear()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        
    }
    
    private func setupViewWillAppear() {
        presenter.favoriteItemsObservers()
        favoriteView.reloadTableView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        favoriteView.favoritesTableViewDataSource(on: self)
        favoriteView.show(next: .placeholderLabel)
    }
}

// MARK: - Extensions -

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countOfCells = DatabaseService.shared.fetchData().count
        return countOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.reuseID,
            for: indexPath
        )
                as? MainTableViewCell else { return UITableViewCell() }
        
        let cellsItemConfigurations = DatabaseService.shared.fetchData()
        cell.recieveItem(item: cellsItemConfigurations[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self

        return cell
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    
    func show(next view: FavoriteView.ShowConfiguration) {
        favoriteView.show(next: view)
        if view == .tableView {
            favoriteView.reloadTableView()
        }
    }
}

extension FavoriteViewController: CellDeletionEnviromentProtocol {
    func cellReload() {
        presenter.favoriteItemsObservers()
    }
}
