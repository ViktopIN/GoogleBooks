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
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        searchView.fillSuperview()
    }
    
}
