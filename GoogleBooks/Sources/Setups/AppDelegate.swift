//
//  AppDelegate.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let searchViewController = SearchViewController()
        let favoriteViewController = FavoriteViewController()
        
        let searchTabBarItemConfiguration = BaseTabBarItem(
            title: "Search",
            imageName: "magnifyingglass.circle",
            viewController: searchViewController,
            tag: 0
        )
        
        let favoriteTabBarItemConfiguration = BaseTabBarItem(
            title: "Favorites",
            imageName: "heart.circle",
            viewController: favoriteViewController,
            tag: 1
        )

        let mainTabBarController = MainTabBarController(inputTabBarItems: [searchTabBarItemConfiguration, favoriteTabBarItemConfiguration])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = searchViewController
        window?.makeKeyAndVisible()
        return true
    }
}

