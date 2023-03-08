//
//  FavoritePresenterProtocol.swift
//  GoogleBooks
//
//  Created by Виктор on 08.03.2023.
//

import Foundation

protocol FavoritePresenterProtocol: AnyObject {
    
    func favoriteItemsObservers()
}

protocol FavoriteViewProtocol: AnyObject {
    func show(next view: FavoriteView.ShowConfiguration)
}
