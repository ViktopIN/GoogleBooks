//
//  NetworkService.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import Alamofire

protocol NetworkSearchServiceProtocol: AnyObject {
    func fetchSearchData(
        searchExpression: String,
        completion: @escaping (Result<GoogleResponseModel, NetworkError>) -> Void
    )
    func loadingImageData(
        imageURL: URL?,
        completion: @escaping (UIImage) -> Void
    )
}

class NetworkService: NetworkSearchServiceProtocol {
    
    let apiService: SearchAPIServiceProtocol
    
    init(apiService: SearchAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchSearchData(
        searchExpression: String,
        completion: @escaping (Result<GoogleResponseModel, NetworkError>) -> Void
    ) {
        AF.request(
            apiService.getSearchURL(searchExpression: searchExpression),
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default
        )
        .validate(statusCode: 200..<299)
        .validate(contentType: ["application/json"])
        .responseData { (responseData) in
            guard let responce = responseData.response
            else {
                return completion(.failure(.serverError)) }
            if responce.statusCode >= 300 {
                completion(.failure(.badURL))
            }
        }
        .responseDecodable(of: GoogleResponseModel.self) { (response) in
            guard let response = response.value
            else {
                return completion(.failure(.badJSON)) }
            
            completion(.success(response))
        }
    }
    
    func loadingImageData(
        imageURL: URL?,
        completion: @escaping (UIImage) -> Void
    ) {
        let placeHolderImage = UIImage(systemName: "books.vertical")!
        guard let imageURL = imageURL
        else {
            completion(placeHolderImage)
            return
        }
        AF.request(imageURL, method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default)
        .validate(statusCode: 200..<299)
        .validate(contentType: ["application/json"])
        .responseData { (responseData) in
            guard let responseData = responseData.value
            else {
                completion(placeHolderImage)
                return
            }
            guard let image = UIImage(data: responseData)
            else {
                completion(placeHolderImage)
                return
            }
            completion(image)
        }
    }

}
