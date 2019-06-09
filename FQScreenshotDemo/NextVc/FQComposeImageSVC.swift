//
//  FQComposeImageSVC.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/5/18.
//  Copyright © 2019 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class FQComposeImageSVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func composeImage(){
        var finishImage = UIImage()
        let bgImage = UIImage()
        let image1 = UIImage()
        let image2 = UIImage()
        let image3 = UIImage()
        let imageArr = [image1,image2,image3]
        
        let rect1 = CGRect()
        let rect2 = CGRect()
        let rect3 = CGRect()
        let rectArr = [rect1,rect2,rect3]
        finishImage = FQShoutManger.share.composeImageWithImage(bgImage: bgImage, imageRect: rectArr, images: imageArr)
    }
}
