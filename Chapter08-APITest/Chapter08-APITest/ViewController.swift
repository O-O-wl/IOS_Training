//
//  ViewController.swift
//  Chapter08-APITest
//
//  Created by 이동영 on 10/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userId.placeholder = "User ID"
        self.name.placeholder = "Name"
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet var currentTime: UILabel!
    
    @IBOutlet var responseView: UITextView!
    
    @IBOutlet var userId: UITextField!
    
    @IBOutlet var name: UITextField!
    
    
    
    @IBAction func post(_ sender: Any) {
        
        /// - Note: 전달할 값 생성 -- reqParameter  , URL 로 넘길수 있게 인코딩
        let userId = (self.userId.text)!
        let name = (self.name.text)!
        let param = "userId=\(userId)&name=\(name)" // POST 요청 HTTP 바디에 들어갈 파라미터
        let reqParam = param.data(using: .utf8)
        print("- Note: 전달할 값 생성 -- reqParameter  , URL 로 넘길수 있게 인코딩")
        
        
        /// - Note:  URL 객체 생성
         let url =  URL(string:"http://swiftapi.rubypaper.co.kr:2029/practice/echo")
        print("- Note:  URL 객체 생성")
        
        /// - Note: URL객체로 URLRequest 객체 생성 , 전송메소드 . 바디 설정
        var request = URLRequest(url: url!)
        request.httpBody = reqParam
        request.httpMethod  = "POST"
        print("- Note: 리퀘스트 해더 설정. -- 콘텐츠타입 - 전송된 메세지 본문의 형식")
        
        /// - Note: 리퀘스트 해더 설정. -- 콘텐츠타입 - 전송된 메세지 본문의 형식
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("\(request.httpBody?.count)", forHTTPHeaderField: "Content-Length")
        print("- Note: 리퀘스트 해더 설정. -- 콘텐츠타입 - 전송된 메세지 본문의 형식")
        
        
        
        /// - Note: URLSession 객체 생성 , 에러처리 , 응답데이터 처리 로직
        // 전송 준비만 된상태 실제 요청은 아직 안이루어짐   - URLSesstionDataTask OBJECT
        /// - Note: 이 밑에 있는 작업들은 모두 서브스레드에서 돌게된다
        let task = URLSession.shared.dataTask(with:request){
            //=============================================
            //      URLRequest에 대한 응답 처리 로직 클로저
            //      param(응답데이터 , 응답코드 , 에러)
            //      type(Data,URLResponse ,Error
            //=============================================
            (data,response,error) in
            
            
            ///======================================================///
            /// - Note: 에러시 응답메세지 본문이 nil 이므로 로직 중지 해야하므로   ///
            ///======================================================///
            if let e = error {
                print("에러 : \(e.localizedDescription)")
                return
            }
            
            
            
            
            
            /** ======================================================
                                    - Note:
                    task의 컴플리트 메소드는 서브 스레드에서 실행된다
                                여기서 UI를 수정할수 없다
                    그러므로 특정로직은 메인스레드에서 실행되도록 이관이 필요하다
                            DispatchQueue.main.async
                    비동기 처리이지만 Main Thread 에서 실행된다
             ========================================================*/
            // - 메인스레드에서 비동기 처리하기위해 --> UI수정가능
            DispatchQueue.main.async {
                
                do{
                    let object  =  try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    
                    guard let jsonObject = object  else {return }
                    
                    let result = jsonObject.value(forKey: "result") as? String
                    let timestamp = jsonObject.value(forKey: "timestamp") as? String
                    let userId = jsonObject.value(forKey: "userId") as? String
                    let name = jsonObject.value(forKey: "name") as? String
                    
                    self.responseView.text = "result:\(result!)\n timestamp:\(timestamp!)\n userId:\(userId!)\n name:\(name!)"
                }catch let error as NSError{
                    print("에러메시지 : \(error.localizedDescription)")
                }
            }
           
            
        }
        ///===================/
        ///     - Note:       /
        ///     테스크 실행      /
        ///===================/
        task.resume()
    
    
    
    }
    
    
    
    
    
    @IBAction func callCurrentTime(_ sender: Any) {
        do{
            let url =  URL(string:"http://swiftapi.rubypaper.co.kr:2029/practice/currentTime")
            
            let response = try String(contentsOf: url!)
            
            self.currentTime.text = response
            self.currentTime.sizeToFit()
            
            
        }catch let error {
            
        }
    }
    
}

