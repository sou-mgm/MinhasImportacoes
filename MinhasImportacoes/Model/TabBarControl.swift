//
//  TabBarControl.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 05/12/22.
//

import UIKit

class TabBarControl: UITabBarController {

    
    @IBOutlet strong var tabBar: UITabBar!
    
    static let shared = TabBarControl()
    func disableTabBar(){
        tabBar.isUserInteractionEnabled = false
    }
    
    func enableTabBar(){
        tabBar.isUserInteractionEnabled = true
    }
}
