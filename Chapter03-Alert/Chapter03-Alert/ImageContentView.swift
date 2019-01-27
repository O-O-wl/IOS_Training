//
//  ImageContentView.swift
//  Chapter03-Alert
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit

class ImageContentView : UIViewController{
    override func viewDidLoad() {
        let image = UIImage(named:"rating5")
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: image!.size.width, height: (image?.size.height)!)
        
        self.preferredContentSize = CGSize(width: imageView.frame.size.width, height: imageView.frame.size.height + 10)
        self.view = imageView
    }
}
