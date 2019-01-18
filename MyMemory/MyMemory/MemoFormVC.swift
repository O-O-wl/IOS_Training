//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 이동영 on 18/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///  텍스트뷰의 delegate인스턴스로 self VC에 위임함
        self.contents.delegate = self
        // Do any additional setup after loading the view.
    }

    // 컨텐츠의 첫줄을 따서 제목으로 설정
    var subject : String!
    
    @IBOutlet var contents: UITextView!
    
    @IBOutlet var preview: UIImageView!

    /**================================================================
                                - Note:
     *                   작성한 메모 저장하는 메소드
     *                   내용 입력여부에 따른 알림창
     ================================================================*/
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else{
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               self.present(alert,animated: true)
            return
        }
        let data = MemoData()
        
        self.fillData(data: data)
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        appDelegate.memoList.append(data)
        
        _=self.navigationController?.popViewController(animated: true)
     print(appDelegate.memoList.count)
        
    }
    
    
    
    /** ==============================================================
                                - Note:
     *                  이미지피커컨트롤러 실행메소드
     *                   내용 입력여부에 따른 알림창
     ================================================================*/
    @IBAction func pick(_ sender: Any) {
        
        // 피커컨트롤러 생성
        let picker = UIImagePickerController()
        
        // 선택한 이미지 편집여부
        picker.allowsEditing = true
        
        // VC인스턴스를 picker의 delegate인스턴스 로 선언
        picker.delegate = self
        
        self.present(picker,animated: false)
        
    }
    
    /** ==============================================================
                                - Note:
     *                  MemoData 도메인 모델 객체에
     *                   입력받은 내용을 저장하는 메소드
     ================================================================*/
    func fillData(data:MemoData) ->(){
        data.title = self.subject
        data.contents = self.contents.text
        data.regdate = Date()
        data.image = (self.preview.image)
        
        
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
// MARK: - 이미지피커 델리게이트
extension MemoFormVC : UIImagePickerControllerDelegate{
    /**===============================================================
                                - Note:
     *       이미지피커 컨트롤러에서 이미지 선택을 마치면 실행되는 콜백메소드
     *                    - Delegate 메소드 -
    ==================================================================*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        // 자동으로 picker를 self로 링킹
        
        picker.dismiss(animated: false, completion: nil)
    }
    
}
// MARK: - 텍스트뷰 델리게이트
extension MemoFormVC : UITextViewDelegate{
    
    /**================================================================
                                - Note:
     *           텍스트뷰의 내용이 변경될 때 마다 호출되는 콜백메소드
     *                    - Delegate 메소드 -
     ==================================================================*/
    func textViewDidChange(_ textView: UITextView) {
        
        // 수정하기 유연한 NSString 객체로 캐스팅
        let contents = textView.text as NSString
        
        /// - Note: 앞에서 부터 15
        let length = contents.length > 15 ? 15 : contents.length
        // 범위 객체 이용
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        /// - Note: 네비게이션 타이틀로 표시
        self.navigationItem.title = subject
    }
}
