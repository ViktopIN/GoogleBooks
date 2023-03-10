//
//  SearchViewProtocol.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func show(next view: SearchView.ShowConfiguration)
}
