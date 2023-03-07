//
//  APIService.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import Foundation

protocol APIServiceProtocol {
    func getURL() -> URL?
}

protocol SearchAPIServiceProtocol: APIServiceProtocol {
    func getSearchURL(searchExpression: String) -> URL
}

class APIService: SearchAPIServiceProtocol {
    
    private var components = URLComponents()
    
    private let scheme = "https"
    private let host = "www.googleapis.com"
    private let path = "/books/v1/volumes"
    
    private let apiKey = "AIzaSyBiP-7qfVT_YVJo0ZekNhI1tHn72N268Fs"
    
    private let startIndexQuery = URLQueryItem(name: "startIndex", value: "0")
    private let maxResultsQuery = URLQueryItem(name: "maxResults", value: "10")
    private var apiKeyQuery: URLQueryItem {
        URLQueryItem(name: "key", value: self.apiKey)
    }
    
    func getURL() -> URL? {
        print(components.url as Any)
        return components.url
    }
    
    func getSearchURL(searchExpression: String) -> URL {
        components = URLComponents()
        let searchQuery = URLQueryItem(name: "q", value: searchExpression)
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [searchQuery, startIndexQuery, maxResultsQuery, apiKeyQuery]
        return getURL()!
    }
}


//func fetchCharacter(completion: @escaping (DataMarvel?, _ error: String?) -> Void) {
//    AF.request(defaultUrl())
//        .responseDecodable(of: DataMarvel.self, queue: .global()) { (response) in
//            if let error = response.error {
//                completion(nil, error.localizedDescription)
//            }
//
//            if let statusCode = response.response?.statusCode, statusCode == 200 {
//                print("Marvel Api Server status -  \(statusCode)")
//            } else if let statusCode = response.response?.statusCode {
//                completion(nil, String(statusCode))
//                return
//            }
//
//            guard let data = response.value else {
//                completion(nil, "No data")
//                return
//            }
//
//            completion(data, nil)
//        }
//}
