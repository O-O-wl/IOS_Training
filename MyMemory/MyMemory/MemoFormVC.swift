//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 이동영 on 18/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    // 컨텐츠의 첫줄을 따서 제목으로 설정
    var subject : String!
    
    @IBOutlet var contents: UITextView!
    
    @IBOutlet var preview: UIImageView!

    
    @IBAction func save(_ sender: Any) {
    }
    
    @IBAction func pick(_ sender: Any) {
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
