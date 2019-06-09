//
//  BaseViewController.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var shotView:UIView!
    private var activityView:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityView()
        initSubVCs()
    }
    
    func initActivityView(){
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 101, height: 101)
        self.navigationController?.navigationBar.addSubview(activityView)
        activityView.center = self.view.center
        activityView.color = UIColor.black
        activityView.backgroundColor = UIColor.clear
        activityView.hidesWhenStopped = true
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "截图", style: UIBarButtonItem.Style.plain, target: self, action: #selector(shotBtn))
    }
    @objc func shotBtn(){
        if shotView != nil{
            startAnimation()
            FQShoutManger.share.screenShot(shotView) {
                [unowned self] (shotImage) in
                self.stopAnimation()
                let vc = ShotViewController(image: shotImage)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    func initSubVCs(){}
    
    func startAnimation(){
        if activityView.isAnimating{return}
        self.navigationController?.navigationBar.bringSubviewToFront(activityView)
        activityView.startAnimating()
    }
    
    func stopAnimation(){
        if activityView.isAnimating{
            activityView.stopAnimating()
        }
    }

}
