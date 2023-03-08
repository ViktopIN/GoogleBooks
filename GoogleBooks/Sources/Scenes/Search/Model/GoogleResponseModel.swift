//
//  GoogleResponseModel.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import Foundation

// MARK: - GoogleResponseModel
struct GoogleResponseModel: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let accessInfo: AccessInfo
}

// MARK: - AccessInfo
struct AccessInfo: Codable {
    let webReaderLink: String
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let imageLinks: ImageLinks?
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let thumbnail: String?
}
