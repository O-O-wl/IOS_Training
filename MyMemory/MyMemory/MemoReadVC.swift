//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by 이동영 on 18/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {

    var memo : MemoData?
    
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "dd일 HH시mm분에 작성됨"
        self.navigationItem.title = dateFormatter.string(from: (memo?.regdate)!)
        self.subject.text = memo?.title
        self.contents.text = memo?.contents
        self.img.image = memo?.image
        self.contents.sizeToFit()
        
        // Do any additional setup after loading the view.
    }
}
