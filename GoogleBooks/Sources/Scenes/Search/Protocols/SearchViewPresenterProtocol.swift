//
//  SearchViewPresenterProtocol.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import Foundation

protocol SearchPresenterProtocol {
    var networkService: any NetworkSearchServiceProtocol { get }
    var model: GoogleResponseModel? { get }
    func getFavorite(item: GoogleResponseModel)
    func fetchSearchingData(by bookName: String)
}
