//
//  AppDelegate.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let searchViewController = SearchViewController()
        let searchPresenter = SearchPresenter(view: searchViewController)
        searchViewController.presenter = searchPresenter
        
        let favoriteViewController = FavoriteViewController()
        let presenterFavorite = FavoritePresenter(view: favoriteViewController)
        favoriteViewController.presenter = presenterFavorite
        
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
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "AppData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


