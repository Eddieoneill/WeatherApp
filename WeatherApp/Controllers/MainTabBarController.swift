//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import DataPersistence

class MainTabBarController: UITabBarController {

    private var dataPersistence = DataPersistence<ImageObject>(filename: "favoriteImage.plist")
        
        private lazy var forecastVC: WeatherViewController = {
            let viewController = WeatherViewController()
            viewController.dataPersistence = dataPersistence
            viewController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "cloud"), tag: 0)
            return viewController
        }()
        private lazy var favoritesVC: FavoritsViewController = {
            let viewController = FavoritsViewController()
            viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
            viewController.dataPersistence = dataPersistence
            return viewController
        }()
    
        private lazy var detailVC: DetailViewController = {
            let viewController = DetailViewController()
            viewController.dataPersistence = dataPersistence
            return viewController
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            viewControllers = [UINavigationController(rootViewController: forecastVC), UINavigationController(rootViewController: favoritesVC)]
        }
        



    }
