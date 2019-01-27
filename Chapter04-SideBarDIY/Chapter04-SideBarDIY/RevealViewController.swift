//
//  RevealViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 이동영 on 28/01/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {
    
    // 콘텐츠를 담당할 뷰 컨트롤러
    var contentVC : UIViewController?
    //사이드 바 메뉴 를 담당할 뷰 컨트롤러
    var sideVC  : UIViewController?
    // 사이드바의 열/닫힘 유무
    var isSideBarShowing  = false
    
    // 사이드바 애니메이션 타임인터벌
    let SLIDE_TIME = 0.3
    // 사이드바가 이동할 너비
    let SIDEBAR_WIDTH : CGFloat = 260

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        
    
      //  self.getSideView()

        // Do any additional setup after loading the view.
    }
    
    /***************************************************
                        - Note:
                        초기 뷰 설정 메소드
            뷰 컨트롤러에 다른 뷰 컨트롤러를 등록하기 위해서는
            뷰 컨트롤러를 등록 , 뷰를 등록 두가지 모두 등록되어야함
                그리고 자식이 된 뷰 컨트롤러에게
             부모 뷰 컨트롤러가가 바뀐걸 인지 시켜주어야한다
    ****************************************************/
    func setUpView(){
        
        // 프론트뷰 컨트롤러 인스턴스 생성
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController{
            
            
            // 클래스내부에서 자연스럽게 접근가능하게 하기위해 전역변수에 참조값 저장
            self.contentVC = vc
            
            // 자식 뷰 컨트롤러로 네비컨트롤러 등록
            self.addChild(vc)
            /// - Note: ViewController , View 는 독립구조 이므로 각각 등록해주어야한다.
            ///  ViewController 만 등록시 View가 안보임 , View만 등록시 이벤트처리 안됨
            // 네비컨트롤러의 루트뷰를 메인컨트롤러 루트뷰의 서브뷰로 등록
            self.view.addSubview(vc.view)
            
            // 네비컨트롤러에게 부모뷰가 바뀌었음을 알려준다.
            vc.didMove(toParent: self)
            
            let frontVC = vc.viewControllers[0] as? FrontViewController
            // 자기 자신을 Front의 위임 메소드로 등록
            frontVC?.delegate = self
            
        }
    }
    
    
    
    
    //======================================================
    ///                    - Note:
    //              사이드 뷰를 가져오는 메소드
    // ======================================================
    func getSideView(){
        if self.sideVC == nil{
            // 사이드바 컨트롤러 객체를 읽어온다
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear"){
                // 다른 메소드에서도 참조 할수 있도록 sideVC 속성에 저장
                self.sideVC = vc
                // 읽어온 사이드 바 컨트롤러 객체를 컨테이너 뷰 컨트롤러에 연결
                
               
          
                
                self.addChild(vc)
                self.view.addSubview(vc.view)
                //self.view.addSubview(vc.view)
                // 사이드바 컨트롤러에 부모 뷰         컨트롤러가 바뀌었음을 알려준다.
                vc.didMove(toParent: self)
                // _프론트 뷰 컨트롤러의 뷰를 제일 위로 올린다.
                
                /// - Note: 아마도 이전에 뷰가 덮어씌어질거같다?
                //self.view = self.contentVC!.view
                self.view.bringSubviewToFront((self.contentVC?.view)!)
                
            }
        }
    }
    
    
    
    
    /***************************************************
                        - Note:
                콘텐츠 뷰에 그림자 효과를 주는 메소드
    ****************************************************/
    func setShadowEffect(shadow:Bool , offset:CGFloat){
        // shadow : Bool  -- 그림자의 적용여부 플래그
        if(shadow == true){
            // 그림자 모서리 둥글기
            self.contentVC?.view.layer.cornerRadius = 10
            // 그림자 투명도
            self.contentVC?.view.layer.shadowOpacity = 0.8
            // 그림자 색상
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            // 그림자 크기
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
            
        }
        else{
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    
    
    
    
    
    //======================================================
    ///                    - Note:
    //                 사이드 바를 여는 메소드
    // ======================================================
    func openSideBar(_ complete:(() -> Void)?){
        // 앞에서 정의했던 메소드들 실행
        self.getSideView()
       
        self.setShadowEffect(shadow: true ,  offset: -2)
        // 애니메이션 옵션  curveEaseInOut - 빨라졋다 느려짐. / beginFromCurrentState - 다른애니메이션 실행되고 있어도 실행시작
        let options  = UIView.AnimationOptions([.curveEaseInOut , .beginFromCurrentState])
        //애니메이션 실행
        /********************************************************
         - Note: withDuration  -  애니메이션 실행시간
         - Note: delay         -  애니메이션 실행전 대기시간
         - Note: options       -  애니메이션 옵션
         - Note: animations    -  애니메이션 실행내용
         - Note: completion    -  애니메이션 완료후 실행할 클로저
        *********************************************************/
            UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)}, completion: {
                if $0 == true {
                    self.isSideBarShowing = true
                    complete?() // openSideBar 매개변수로 받은 메소드
                }
            }
        )
    }
    
    
    
    
    
    /***************************************************
                        - Note:
                  사이드 바를 닫는 메소드
     ****************************************************/
    func closeSideBar(_ complete : ( () -> Void)?){
        
        // 앞에서 정의했던 메소드들 실행
        self.getSideView()
        self.setShadowEffect(shadow:true ,  offset: -2)
        // 애니메이션 옵션  curveEaseInOut - 빨라졋다 느려짐. / beginFromCurrentState - 다른애니메이션 실행되고 있어도 실행시작
        let options  = UIView.AnimationOptions([.curveEaseInOut , .beginFromCurrentState])
        //애니메이션 실행
        /********************************************************
         - Note: withDuration  -  애니메이션 실행시간
         - Note: delay         -  애니메이션 실행전 대기시간
         - Note: options       -  애니메이션 옵션
         - Note: animations    -  애니메이션 실행내용
         - Note: completion    -  애니메이션 완료후 실행할 클로저
         *********************************************************/
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)}, completion: {
            if $0 == true {
                //  사이드뷰 슈퍼뷰로 부터 분리
                self.sideVC!.view.removeFromSuperview()
                //  메모리 헤제
                self.sideVC = nil
                
                self.isSideBarShowing = false
                self.setShadowEffect(shadow: false, offset: 0)
                complete?()
            }
        }
        )
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
