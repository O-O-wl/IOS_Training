//
//  FrontViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 이동영 on 28/01/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {

    // 눌리면 여기에 저장되있는 뷰 컨트롤러로 이벤트 알림 전달
    var delegate :RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu"), style: .plain, target: self, action: #selector(moveSide(_:)))

        self.navigationItem.leftBarButtonItem = btnSideBar
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func moveSide(_ sender : Any){
        if self.delegate?.isSideBarShowing == false{
            self.delegate?.openSideBar(nil)
        }else{
            self.delegate?.closeSideBar(nil)
        }
    }

}
