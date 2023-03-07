//
//  NetworkService.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import Foundation
import UIKit
import Alamofire

protocol NetworkServiceProtocol {
    func fetchCharactersData(completion: @escaping (Result<MarvelInfo, NetworkError>) -> Void)
    func fetchComicsData(with id: String, completion: @escaping (Result<[Character], NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {

    func fetchCharactersData(completion: @escaping (Result<MarvelInfo, NetworkError>) -> Void) {
        getData(completion: completion)
    }

    func fetchComicsData(with id: String, completion: @escaping (Result<[Character], NetworkError>) -> Void) {

        var url: String { "\(UserSettings.baseURL)\(UserSettings.endPointCharacters)/\(id)/\(UserSettings.endPointComics)" }

        AF.request(url, method: .get,
                   parameters: ["apikey": UserSettings.publicKey,
                                "ts": UserSettings.tsForApi,
                                "hash": UserSettings.hash],
                   encoding: URLEncoding.default)
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
            .responseDecodable(of: MarvelInfo.self) { (response) in
                guard let characters = response.value?.data
                else {
                    return completion(.failure(.badJSON)) }

                completion(.success(characters.results))
            }
    }
}

private extension NetworkService {
    
    @available(*, renamed: "getData()")
    func getData<T: Decodable>( completion: @escaping (Result<T, NetworkError>) -> Void) {
        Task {
            do {
                let result: T = try await getData()
                completion(.success(result))
            } catch {
                completion(.failure(error as! NetworkError))
            }
        }
    }
    
    
    func getData<T: Decodable>() async throws -> T {
        guard let url1 = URL.url(with: UserSettings.baseURL, endpoint: UserSettings.endPointCharacters, queryParametrs: UserSettings.queryItems) else {
            throw .badURL
            return
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: url1) { data, response, error in
                guard let response1 = response as? HTTPURLResponse,
                      (200...299).contains(response1.statusCode)
                else {
                    continuation.resume(with: .failure(.serverError))
                    print(NetworkError.serverError.localizedDescription)
                    return
                }
                
                guard let data1 = data,
                      let model = try? JSONDecoder().decode(T.self, from: data1)
                else {
                    continuation.resume(with: .failure(.badJSON))
                    return
                }
                continuation.resume(with: .success(model))
            }
            task.resume()
        }
    }
}
