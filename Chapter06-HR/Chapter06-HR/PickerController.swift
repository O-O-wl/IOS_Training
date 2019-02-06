//
//  PickerController.swift
//  Chapter06-HR
//
//  Created by 이동영 on 05/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation
import UIKit

class DepartPickerVC : UIViewController , UIPickerViewDelegate,UIPickerViewDataSource{
    
    let departDAO = DepartmentDAO()
    
    var departList : [(departCd:Int,departTitle:String,departAddr:String)]!
    
    var pickerView : UIPickerView!
    

    
    
    // 현재 선택되어있는 피커뷰 부서코드
    var selectedDepartCd : Int{
        
        // 컴포넌트 인덱스
        let row = self.pickerView.selectedRow(inComponent: 0)
        
        //
        return self.departList[row].departCd
    }
    
    
    
    override func viewDidLoad() {
        self.departList = self.departDAO.find()
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        
        self.view.addSubview(self.pickerView)
        
        let pWidth = self.pickerView.frame.width
        let pHeight  = self.pickerView.frame.height
        self.preferredContentSize = CGSize(width: pWidth, height: pHeight)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.departList.count
    }
    
    /**
     - Note: 타이틀 텍스트만 반환 -- 문자열 속성 설정할 수 없음 (폰트 등등 - 뷰에서 설정)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowData = self.departList[row]
        return "\(rowData.departTitle)(\(rowData.departAddr))"
    }
 */
 
    
    // 피커뷰 표시될 데이터 셋팅
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let rowData = self.departList[row]
        
        // 클로저로 초기화
        let titleView  = view as? UILabel ?? {
            let titleView = UILabel()
            titleView.font = UIFont.systemFont(ofSize: 14)
            titleView.textAlignment = .center
            return titleView
        }()
       titleView.text = "\(rowData.departTitle)(\(rowData.departAddr))"
        
        return titleView
    }
    
}
