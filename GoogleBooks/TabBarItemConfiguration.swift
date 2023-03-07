//
//  TabBarItemConfiguration.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

protocol TabBarItemConfiguration {
    var title: String { get set }
    var imageName: String { get set }
    var viewController: UIViewController { get set }
    var tag: Int { get set }
}

class BaseTabBarItem: TabBarItemConfiguration {
    var title: String
    var imageName: String
    var viewController: UIViewController
    var tag: Int
    
    init(title: String = "Item", imageName: String = "folder", viewController: UIViewController, tag: Int) {
        self.title = title
        self.imageName = imageName
        self.viewController = viewController
        self.tag = tag
    }
}
