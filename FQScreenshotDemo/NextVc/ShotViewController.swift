//
//  ShotViewController.swift
//  FQScreenshotDemo
//
//  Created by 付强 on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

 class ShotViewController: UIViewController {
    
    private var scrollView:UIScrollView!
    private var imageView:UIImageView!
    private var image:UIImage!
    
    
    init(image:UIImage){
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        //adjustsScrollviewInset()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存截图", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveImage))
    }
    
    func initViews(){
        view.backgroundColor = UIColor.white
        
        imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        scrollView = UIScrollView()
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        var scrollViewFrame = self.view.bounds
        scrollViewFrame.origin.y = UIApplication.shared.statusBarFrame.size.height
        scrollView.frame = scrollViewFrame
        
        let height = self.image.size.height
        let width = self.image.size.width
        scrollView.contentSize = CGSize(width: width, height: height)
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    @objc func saveImage(){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedPhotosAlbum(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func adjustsScrollviewInset(){
        if #available(iOS 11.0, *){
            scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    @objc func savedPhotosAlbum(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        var barItemTitle = "保存成功"
        if error != nil{
            barItemTitle = "保存失败"
        }
        self.navigationItem.rightBarButtonItem?.title = barItemTitle
    }
}
