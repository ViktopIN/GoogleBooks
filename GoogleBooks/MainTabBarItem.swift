//
//  MainTabBarItem.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//


import UIKit

class MainTabBarItem: UITabBarItem {
    init(
        title: String?,
        image: UIImage?,
        tag: Int
    ) {
        super.init()
        self.title = title
        self.image = image
        self.tag = tag
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
