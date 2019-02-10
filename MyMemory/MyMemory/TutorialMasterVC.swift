//
//  TutorialMasterVC.swift
//  MyMemory
//
//  Created by 이동영 on 10/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

class TutorialMasterVC  : UIViewController , UIPageViewControllerDataSource{
  
    
    
    var pageVC  : UIPageViewController!
    
    var contentTitles = ["STEP 1","STEP 2","STEP 3","STEP 4"]
    
    var contentsImages = ["page0","page1","page2","page3"]
    
    
    
    // 처음 실행시
    override func viewDidLoad() {
        
        // 페이지뷰컨트롤러 생성 , 델리게이트
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as! UIPageViewController
        self.pageVC.dataSource = self
        
        // 첫 콘텐츠뷰 생성
        let startContentVC = self.getContentVC(atIndex: 0)!
        
        /**===============================================
            - Note: 페이지뷰컨트롤러에 VC의 배열 설정
        /===============================================*/
        self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true, completion:nil)
        
        
        self.pageVC.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC.view.frame.size.width = self.view.frame.width
        self.pageVC.view.frame.size.height = self.view.frame.height - 50
        
        self.addChild(self.pageVC) // 마스터컨트롤러에 페이자뷰컨트롤러 추가
        self.view.addSubview(self.pageVC.view)  //VC , view는 별개추가
        self.pageVC.didMove(toParent: self)     // pageVC 에게 부모뷰컨트롤러가 바뀌었음을 알려준다
        /// - Note: 추측? - 부모뷰에서는 설정을 다해줘서알지만 자식뷰는 사실상 자기 자신에게 처리한것은 없으므로 필요한 구문
        
 
    }
    
    
    @IBAction func close(_ sender: Any) {
        
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        
        self.presentingViewController?.dismiss(animated: true)
    
    }
    
    
    
    
    func getContentVC(atIndex index: Int) -> UIViewController? {
        guard self.contentTitles.count >=  index && self.contentTitles.count > 0 else{
            
            return nil
            
            
        }
        
        guard let ContentsVC  = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else{
            return nil
        }
        ContentsVC.titleText = self.contentTitles[index]
        ContentsVC.imgFile = self.contentsImages[index]
        ContentsVC.pageIndex = index
        return ContentsVC
        
    }
    
}
// - MARK: - 데이터소스 메소드 영역 - 페이지뷰컨트롤러의 데이터소스 구현부 - UIPageViewControllerDataSource

extension TutorialMasterVC {
    /**===============================================
        - Note: 현재 페이지뷰의 이전 콘텐츠뷰 컨트롤러 반환메소드
    /===============================================*/
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        // 현재 페이지가 0 보다 큰지확인
        guard index > 0 else{
            return nil
        }
        
        
        index -= 1
        return self.getContentVC(atIndex: index)
        
    }
    
    
    /**===============================================
     - Note: 현재 페이지뷰의 이후 콘텐츠뷰 컨트롤러 반환메소드
    /===============================================*/
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
       
        index += 1
        
        // 다음페이지가 마지막 페이지보다 큰지확인
        guard index < self.contentsImages.count else{
            return nil
        }
        
        return self.getContentVC(atIndex: index)
    }
}
// - MARK: - 페이지 인디케이터를 설정하는 코드
extension TutorialMasterVC{
    
    /** =============================
     - Note: 페이지 인디케이터의 총갯수
     ===============================*/
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentTitles.count
    }
    /** =============================
     - Note: 첫페이지의 인덱스
     ===============================*/
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    
    
    
    
}
