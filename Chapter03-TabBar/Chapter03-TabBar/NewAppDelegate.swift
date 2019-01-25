//
//  NewAppDelegate.swift
//  Chapter03-TabBar
//
//  Created by 이동영 on 25/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
class NewAppDelegate : UIResponder,UIApplicationDelegate{
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        var tvc = UITabBarController()
        self.window?.rootViewController = tvc
        let vc1 = ViewController()
        let vc2 = ViewController2()
        let vc3 = ViewController3()
        tvc.setViewControllers([vc1,vc2,vc3], animated: false)
        tvc.view.backgroundColor = UIColor.white
        //let tbItem = tvc.tabBarItem
        
        if let tbItems = tvc.tabBar.items{

            tbItems[0].image = UIImage(named: "calendar.png")
            tbItems[0].title = "calender"
            tbItems[1].image = UIImage(named: "file-tree.png")
            tbItems[1].title = "file"
            tbItems[2].image = UIImage(named: "photo.png")
            tbItems[2].title = "photo"
        
        // 탭바 자체의 색
        tvc.tabBar.barTintColor  = UIColor(patternImage: UIImage(named: "menubar-bg")! )
        /// - Note: 외형프락시 객체를 통한 공통속성제어
        let tbItemProxy = UITabBarItem.appearance() // 프락시 참조
        
        tbItemProxy.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.red], for:  .selected)
        tbItemProxy.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.gray], for:  .disabled)
        tbItemProxy.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 15)], for:  .normal)
        
        for tbItem in tbItems{
            tbItem.selectedImage = UIImage(named: "checkmark")
        }
        
        
    
        }

    
}
}
