//
//  FrontViewController.swift
//  Chapter04-SideBar
//
//  Created by 이동영 on 28/01/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet var sideBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let revealVC = self.revealViewController(){
            /*******************************************************
                                 - Note:
                    button.addTarget(target , action , for ) 을
                     UIBarButtonItem 이므로 addTarget() 사용불가
                             각각을 대입하여 구현
                이벤트 타입은 touchUpInside 로 통일 - UIBarButtonItem
            *******************************************************/
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
        }
        
    }

}
