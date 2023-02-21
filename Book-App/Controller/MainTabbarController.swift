//
//  MainTabbarController.swift
//  Book-App
//
//  Created by Akın Çetin on 21.02.2023.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        lazy var homeScreen = ViewController()
        lazy var homeNavController = UINavigationController(rootViewController: homeScreen)
        homeNavController.tabBarItem.image = UIImage(systemName: "house")
        homeNavController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        lazy var profileSrenn = UIViewController()
        lazy var profileScreenNavController = UINavigationController(rootViewController: profileSrenn)
        profileScreenNavController.tabBarItem.image = UIImage(systemName: "person")
        profileScreenNavController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        lazy var cartSrenn = UIViewController()
        lazy var cartScreenNavController = UINavigationController(rootViewController: cartSrenn)
        cartScreenNavController.tabBarItem.image = UIImage(systemName: "cart")
        cartScreenNavController.tabBarItem.selectedImage = UIImage(systemName: "cart.fill")
        
        lazy var categoryScreen = CategoryScreen()
        lazy var categoryScreenNavController = UINavigationController(rootViewController: categoryScreen)
        categoryScreenNavController.tabBarItem.image = UIImage(systemName: "chart.bar.doc.horizontal")
        categoryScreenNavController.tabBarItem.selectedImage = UIImage(systemName: "chart.bar.doc.horizontal.fill")
        
        viewControllers = [homeNavController, categoryScreenNavController, cartScreenNavController, profileScreenNavController]
        
    }
}
