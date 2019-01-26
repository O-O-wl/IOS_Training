//
//  ViewController.swift
//  Chapter03-NavigationBar
//
//  Created by 이동영 on 25/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleUrl()
        self.addTitleItem()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /**  ======================================================
     - Note: 레이블 2개를 가진 뷰 오브젝트를 타이틀 뷰로 설정 하는 메소드
     ==========================================================*/

    func titleInit() {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        title.text = "58개 숙소 \n (9/19~9/20)"
        title.numberOfLines = 2
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textAlignment = .center
        title.textColor = UIColor.white
        
        
        //title.backgroundColor = UIColor.blue
        
      //  let item = UINavigationItem()
        
        self.navigationController?.navigationBar.barTintColor = .blue
        self.navigationItem.titleView = title
        
    }
    
    /**  ======================================================
        - Note: 레이블 2개를 가진 뷰 오브젝트를 타이틀 뷰로 설정 하는 메소드
    ==========================================================*/
    func titleInitNew() {
        let containerTitle = UIView(frame:CGRect(x: 0, y: 0, width: 200, height: 50))
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        title.text = "58개 숙소"
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textAlignment = .center
        title.textColor = UIColor.white
        
        let title2 = UILabel(frame: CGRect(x: 0, y: 15, width: 200, height: 40))
        title2.text = "(9/19~9/20)"
        title2.font = UIFont.boldSystemFont(ofSize: 13)
        title2.textAlignment = .center
        title2.textColor = UIColor.yellow
        
        
        containerTitle.addSubview(title)
        containerTitle.addSubview(title2)
        //title.backgroundColor = UIColor.blue
        
        //  let item = UINavigationItem()
        
        self.navigationController?.navigationBar.barTintColor = .blue
        self.navigationItem.titleView = containerTitle
        
    }
    /**  ======================================================
     - Note: 이미지 뷰를  타이틀 뷰로 설정 하는 메소드
     ==========================================================*/

    func titleImage(){
        
        let title = UIImageView()
        title.image = UIImage(named: "swift_logo")
        self.navigationItem.titleView = title
    }
    
    /**  ======================================================
     - Note: 텍스트필드를  타이틀 뷰로 설정 하는 메소드
     ==========================================================*/
    
    func titleUrl(){
        
        let title = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 35))
        
        /// - Note: 대소문자 입력
        title.autocapitalizationType = .none
        
        /// - Note: 자동완성
        title.autocorrectionType = .no
        
        /// - Note: 키보드타입
        title.keyboardType = .URL
        
        /// - Note:
        title.placeholder = " https://github.com/ldcpaul/IOS_Training"
        
        /// - Note: 단어 철자 확인
        title.spellCheckingType = .no
        
        /// - Note: 키보드 색상테마
        title.keyboardAppearance = .dark
        
        title.font = UIFont.systemFont(ofSize: 13)
        
        /// - Note: layer 가 붙는 이유는 UIView 속성이므로
        title.layer.borderColor = UIColor.gray.cgColor
        
        title.layer.borderWidth = 0.3
        
        title.layer.cornerRadius = 5
        
        
        title.backgroundColor = .white
        
        
        self.navigationItem.titleView = title
        self.navigationController?.navigationBar.barTintColor = .gray
    }
    
    func addTitleItem(){
        let item = UIBarButtonItem(barButtonSystemItem: .done, target: <#T##Any?#>, action: <#T##Selector?#>)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        performSegue(withIdentifier: "test", sender: self)
    }
    
    
    
   
}

