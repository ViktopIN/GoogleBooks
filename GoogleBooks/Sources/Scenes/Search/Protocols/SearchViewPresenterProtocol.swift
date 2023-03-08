//
//  SearchViewPresenterProtocol.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject{
    var networkService: any NetworkSearchServiceProtocol { get }
    var model: GoogleResponseModel? { get }
    func fetchSearchingData(by bookName: String)
}
