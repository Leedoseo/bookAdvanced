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
        
        let mainVC = MainViewController()
        let cartVC = CartViewController()
        mainVC.cartViewController = cartVC // MainViewController에서 CartViewController 참조
        
        mainVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        cartVC.tabBarItem = UITabBarItem(title: "장바구니", image: UIImage(systemName: "cart"), tag: 1)
        
        viewControllers = [mainVC, cartVC]
    }
}
