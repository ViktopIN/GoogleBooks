//
//  MainTabBarController.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    private var tabBarItems = [TabBarItemConfiguration]()
    
    
    // MARK: - Initialise
    init(inputTabBarItems: [TabBarItemConfiguration]) {
        self.tabBarItems = inputTabBarItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setttings
    
    private func configureTabBar() {
        self.tabBar.backgroundColor = .white
        let viewControllers = tabBarItems.map { setBarItem($0) }
        setViewControllers(viewControllers, animated: true)
    }
    
    // MARK: - Private Methods
    
    func setBarItem(_ tabBarItem: TabBarItemConfiguration) -> UIViewController {
        let viewController = tabBarItem.viewController
        viewController.tabBarItem = MainTabBarItem(
            title: tabBarItem.title,
            image: UIImage(systemName: tabBarItem.imageName),
            tag: tabBarItem.tag
        )
        return viewController
    }
}
