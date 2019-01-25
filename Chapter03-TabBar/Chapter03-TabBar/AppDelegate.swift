//
//  AppDelegate.swift
//  Chapter03-TabBar
//
//  Created by 이동영 on 25/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let tvc = self.window?.rootViewController as? UITabBarController {
            
            if let tbItems = tvc.tabBar.items{
                /** =================================================
                tbItems[0].image = UIImage(named: "calendar.png")
                tbItems[0].title = "calender"
                tbItems[1].image = UIImage(named: "file-tree.png")
                tbItems[1].title = "file"
                tbItems[2].image = UIImage(named: "photo.png")
                tbItems[2].title = "photo"
                =====================================================*/
              
                tbItems[0].image = UIImage(named: "facebook")?.withRenderingMode(.alwaysOriginal)
                tbItems[0].title = "facebook"
                
                tbItems[1].image = UIImage(named: "twitter")?.withRenderingMode(.alwaysOriginal)
                tbItems[1].title = "twitter"
                
               
                tbItems[2].image = UIImage(named: "rss")?.withRenderingMode(.alwaysOriginal)
                
                tbItems[2].title = "rss"
                /// - Note: 활성 탭 아이템 색상
                tvc.tabBar.tintColor = UIColor.white
                
                // tvc.tabBar.backgroundImage = UIImage(named: "menubar-bg")?
                //     .stretchableImage(withLeftCapWidth: 5, topCapHeight:0)
                
                
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
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

