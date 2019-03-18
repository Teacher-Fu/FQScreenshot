//
//  UIWebView+FQScreenShot.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit
import WebKit

extension WKWebView{
    func screenShot(finishBlock:imageBackBlock?){
        //获取父视图
        var superView:UIView
        let currentVC = UIViewController.currentViewController()
        if (currentVC != nil){
            superView = (currentVC?.view)!
        }else{
            superView = self.superview!
        }
        //添加遮盖
        let shotView = superView.snapshotView(afterScreenUpdates: true)
        shotView?.frame = CGRect(x: superView.frame.origin.x, y: superView.frame.origin.y, width: (shotView?.frame.width)!, height: (shotView?.frame.height)!)
        superView.addSubview(shotView!)
        
        //保存原始信息
        let oldFrame = self.frame
        let oldOffset = self.scrollView.contentOffset
        let contentSize = self.scrollView.contentSize
        
        //计算快照屏幕数
        let shotCount = floor(contentSize.height / self.scrollView.bounds.size.height)
        
        //设置frame为contentSize
        self.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        self.scrollView.contentOffset = CGPoint.zero
        UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)
        //截取完所有图片
        self.scrollToDraw(index: 0, maxIndex: Int(shotCount)) {
            [unowned self] in
            shotView?.removeFromSuperview()
            let shotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.frame = oldFrame
            self.scrollView.contentOffset = oldOffset
            if finishBlock != nil{
                finishBlock?(shotImage!)
            }
        }
        
    }
    //滑动画了再次截图
    private func scrollToDraw(index:Int,maxIndex:Int,finishBlock:VoidBlock?){
        let shotView = self.superview
        //截取的frame
        let shotFrame = CGRect(x: 0, y: CGFloat(index) * (shotView?.bounds.size.height)!, width: (shotView?.bounds.size.width)!, height: (shotView?.bounds.size.height)!)
        //设置 UIWebView origin_Y
        var myFrame  = self.frame
        myFrame.origin.y = -(CGFloat(index) * (shotView?.frame.size.height)!)
        self.frame = myFrame
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            shotView?.drawHierarchy(in: shotFrame, afterScreenUpdates: true)
            if index < maxIndex{
                self.scrollToDraw(index: index + 1, maxIndex: maxIndex, finishBlock: finishBlock)
            }else{
                if finishBlock != nil{
                    finishBlock?()
                }
            }
        }
    }
}


