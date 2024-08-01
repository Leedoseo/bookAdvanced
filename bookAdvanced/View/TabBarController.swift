//
//  TabBarController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray  
        
        let mainVC = MainViewController()
        mainVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        // 아직 미생성 장바구니로 쓸거임
        let cartVC = CartViewController()
        cartVC.view.backgroundColor = .white
        cartVC.tabBarItem = UITabBarItem(title: "장바구니", image: UIImage(systemName: "cart"), tag: 1)
        
        
        viewControllers = [mainVC, cartVC]
    }
}
