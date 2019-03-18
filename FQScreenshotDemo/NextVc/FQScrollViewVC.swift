//
//  FQScrollViewVC.swift
//  FQScreenshotDemo
//
//  Created by 付强 on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class FQScrollViewVC: BaseViewController {
    private var scrollView:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func initSubVCs() {
        let screenBounds = UIScreen.main.bounds
        scrollView = UIScrollView(frame: screenBounds)
        scrollView?.backgroundColor = UIColor.white
        scrollView?.contentSize = CGSize(width: screenBounds.width, height: screenBounds.height*3)
        view.addSubview(scrollView)
        shotView = scrollView
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: scrollView.contentSize.height))
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        
        for index in 0...400 {
            label.text = label.text?.appending("我的第\(index)个测试文本")
            
        }
        scrollView.addSubview(label)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
}
