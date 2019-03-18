//
//  UIScrollView+FQScreenshot.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/15.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

internal extension UIScrollView{
    func screenShot(finishBlocck:imageBackBlock?){
        var shotImage:UIImage?
        //保存offset
        let oldContent = self.contentOffset
        //保存frame
        let oldFrame = self.frame
        
        if self.contentSize.height > self.frame.height{
            self.contentOffset = CGPoint(x: 0, y:self.contentSize.height - self.frame.height)
        }
        self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
        //延时操作
        Thread.sleep(forTimeInterval: 0.3)
        self.contentOffset = CGPoint.zero
        autoreleasepool {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
            let currentContent = UIGraphicsGetCurrentContext()
            self.layer.render(in: currentContent!)
            shotImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        self.frame = oldFrame
        self.contentOffset = oldContent
        if shotImage != nil && finishBlocck != nil{
            finishBlocck?(shotImage!)
        }
    }
    
    /*
     *  shotView:需要截取的view
     */
    static func screenShotWithShotView(_ shotView:UIView) -> UIImage{
        return self.screenShotWithShotView(shotView, shotSize: CGSize.zero)
    }
    /*
     *  shotView:需要截取的view
     *  shotSize:需要截取的size
     */
    static func screenShotWithShotView(_ shotView:UIView,shotSize:CGSize) -> UIImage{
        var shotImage:UIImage?
        var newShotSize = shotSize
        autoreleasepool{
            if newShotSize.height == 0 || newShotSize.width == 0{
                newShotSize = shotView.bounds.size
            }
            //创建
            UIGraphicsBeginImageContextWithOptions(newShotSize, false, UIScreen.main.scale)
            let currentContext = UIGraphicsGetCurrentContext()
            shotView.layer.render(in: currentContext!)
            //获取图片
            shotImage = UIGraphicsGetImageFromCurrentImageContext()
            //关闭
            UIGraphicsEndImageContext()
        }
        return shotImage!
    }
}
