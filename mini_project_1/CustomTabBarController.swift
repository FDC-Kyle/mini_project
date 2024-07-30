//
//  CustomTabBarController.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 7/29/24.
//

import UIKit
import SwiftUI

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
            super.viewDidLoad()
            
            let viewController1 = ViewController()
            viewController1.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
            
            let viewController2 = UIViewController() // Another view controller
            viewController2.view.backgroundColor = .white
            viewController2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
            
            self.viewControllers = [viewController1, viewController2]
        }
}
