//
//  TabBarController.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 05/12/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        disableTabBar()
    }
    
    func disableTabBar(){
        let tabBarItems = self.tabBar.items
        if let barItems = tabBarItems, barItems.count > 0 {
          let tabBarItem = barItems[0]
          let tabBarItem1 = barItems[1]
          tabBarItem.isEnabled = false
          tabBarItem1.isEnabled = false
            loadingRest.sleepTime(wait: 7) {
                tabBarItem.isEnabled = true
                tabBarItem1.isEnabled = true
            }
          
        }
    }

}
