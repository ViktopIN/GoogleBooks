//
//  FavoritePresenter.swift
//  GoogleBooks
//
//  Created by Виктор on 08.03.2023.
//

import Foundation

class FavoritePresenter: FavoritePresenterProtocol {
    
    // MARK: - Properties
    
    unowned var view: FavoriteViewProtocol
    
    // MARK: - Init
    
    init(view: FavoriteViewProtocol) {
        self.view = view
    }
    
    // MARK: - Methods
    
    func favoriteItemsObservers() {
        if DatabaseService.shared.fetchData().count != 0 {
            view.show(next: .tableView)
        } else {
            view.show(next: .placeholderLabel)
        }
    }
}
