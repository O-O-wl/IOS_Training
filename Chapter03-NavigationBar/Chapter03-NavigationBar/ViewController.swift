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
               //self.addTitleItem()
        
        self.initTitleInput2()
        self.titleUrl()

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
        
        // 네비게이션아이템은 단일 뷰
        self.navigationItem.titleView = title
        
        
        // 네비게이션 컨트롤러는 앱 전체의 네비게이션 속성
        /// - Note: barTintColor : 네비바 전체 색 / tintColor 아이템들의 tintcolor
        self.navigationController?.navigationBar.barTintColor = .gray
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func addTitleItem(){
        let more = UIImage(named: "more")
        
        /** **************************************************************************
              - Note: UIBarButtonItem 는 뷰를 상속하지 않으므로 addSubView x
              - Note: target  - 액션메소드가 정의되어 있는 클래스
        *******************************************************************************/
        let item = UIBarButtonItem(image: more, style: .done, target: self, action: #selector(nextPage))
        //item.tintColor = .white
        self.navigationItem.rightBarButtonItem = item
    }

    @objc func nextPage(){
        performSegue(withIdentifier: "test", sender: self)
    }
    
    func initTitleInput(){
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 150, height: 37)
        v.backgroundColor = .purple
        
        let v2 = UIView()
        v2.frame = CGRect(x: 0, y: 0, width: 100, height: 37)
        v2.backgroundColor = .red
        
        let leftItem = UIBarButtonItem(customView: v)
        let rightItem = UIBarButtonItem(customView: v2)
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    
    func initTitleInput2(){
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
        
        
        let windows = UILabel()
        windows.frame = CGRect(x: 0, y: 0, width:35, height: 37)
        windows.layer.cornerRadius = 5
        windows.textAlignment = .center
        windows.text = "12"
        windows.layer.borderWidth = 3
        windows.layer.borderColor = UIColor.black.cgColor
        
        let more = UIImage(named: "more")
        
       
        
       let item = UIButton(frame: CGRect(x: 40, y: 0, width:35, height: 37))
        item.setImage(more, for: .normal)
        item.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        
        
        v.addSubview(windows)
        v.addSubview(item)
        let rightItem = UIBarButtonItem(customView: v)
        self.navigationItem.rightBarButtonItem = rightItem
    }
   
}

