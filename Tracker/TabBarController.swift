//
//  TabBarController.swift
//  Tracker
//
//  Created by Kirill Gontsov on 06.11.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trackersViewController = TrackersViewController()
        let trackersNavigationController = UINavigationController(rootViewController: trackersViewController)
        let statisticViewController = StatisticViewController()

        let trackersImage = UIImage(named: "trackerTabBarIcon")
        let statisticsImage = UIImage(named: "statisticsTabBarIcon")

        trackersViewController.tabBarItem = UITabBarItem(title: "Трекеры", image: trackersImage, selectedImage: nil)
        statisticViewController.tabBarItem = UITabBarItem(title: "Статистика", image: statisticsImage, selectedImage: nil)

        self.viewControllers = [trackersNavigationController, statisticViewController]
    }
}
