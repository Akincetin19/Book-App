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
        homeNavController.title = "Ana Sayfa"
        
        lazy var profileSrenn = ProfileScreen()
        lazy var profileScreenNavController = UINavigationController(rootViewController: profileSrenn)
        profileScreenNavController.tabBarItem.image = UIImage(systemName: "person")
        profileScreenNavController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        profileScreenNavController.title = "Profil"
        
        lazy var cartSrenn = CartScreen()
        lazy var cartScreenNavController = UINavigationController(rootViewController: cartSrenn)
        cartScreenNavController.tabBarItem.image = UIImage(systemName: "cart")
        cartScreenNavController.tabBarItem.selectedImage = UIImage(systemName: "cart.fill")
        cartScreenNavController.title = "Sepetim"
        
        lazy var categoryScreen = CategoryScreen()
        lazy var categoryScreenNavController = UINavigationController(rootViewController: categoryScreen)
        categoryScreenNavController.tabBarItem.image = UIImage(systemName: "chart.bar.doc.horizontal")
        categoryScreenNavController.tabBarItem.selectedImage = UIImage(systemName: "chart.bar.doc.horizontal.fill")
        categoryScreenNavController.title = "Kategoriler"
        
        viewControllers = [homeNavController, categoryScreenNavController, cartScreenNavController, profileScreenNavController]
        
    }
}
