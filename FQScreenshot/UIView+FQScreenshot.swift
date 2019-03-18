//
//  UIView+FQScreenshot.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/15.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

extension UIView{
    
    func viewScreenShot(finishBlock:imageBackBlock?){
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        let currentContent = UIGraphicsGetCurrentContext()
        layer.render(in: currentContent!)
        let shotImage = UIGraphicsGetImageFromCurrentImageContext()
        if finishBlock != nil{
            finishBlock?(shotImage!)
        }
    }
    
    func viewScrrenSnpShot(finishBlock:imageBackBlock?){
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let shotImage = renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
        Thread.sleep(forTimeInterval: 0.3)
        if finishBlock != nil{
            finishBlock?(shotImage)
        }
    }
}
