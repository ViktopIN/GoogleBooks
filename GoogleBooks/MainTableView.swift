//
//  MainTableView.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

class MainTableView: UITableView {
    
    private func viewConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsVerticalScrollIndicator = false
        self.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
    }
}
