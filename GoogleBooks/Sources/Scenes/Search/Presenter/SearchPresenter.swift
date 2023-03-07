//
//  SearchPresenter.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    
    var view: SearchViewProtocol
    var networkService: NetworkSearchServiceProtocol = NetworkService(apiService: APIService())
    var model: GoogleResponseModel?
    
    func getFavorite(item: GoogleResponseModel) {
        print("get favorite")
    }
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    func fetchSearchingData(by bookName: String) {
        networkService.fetchSearchData(searchExpression: bookName) { result in
            switch result {
            case .success(let success):
                self.model = success
                self.view.show(next: .tableView)
            case .failure(let failure):
                self.view.show(next: .placeholderLabel)
                break
            }
        }
    }

}
