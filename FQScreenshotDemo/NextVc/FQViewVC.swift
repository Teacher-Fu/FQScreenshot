//
//  FQViewVC.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class FQViewVC: BaseViewController {

    var fqView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch  = touches.first!
        if NSStringFromClass(type(of: touch.view!.self)) == "iosVC"{
            
        }
    }
    override func initSubVCs() {
        fqView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        fqView.backgroundColor = UIColor.yellow
        fqView.center = view.center
        view.addSubview(fqView)
        
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "我是 FQView"
        fqView.addSubview(label)
        
        shotView = fqView
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
}
