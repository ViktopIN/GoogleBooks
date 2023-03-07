//
//  MainTableView.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

class MainTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        viewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsVerticalScrollIndicator = false
        self.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: MainTableViewCell.reuseID
        )
    }
}
