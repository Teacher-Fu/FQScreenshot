//
//  FQDoImageVC.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/5/18.
//  Copyright © 2019 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class FQDoImageVC: UIViewController {

    @IBOutlet weak var doImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setImage (){
        let currentPath = Bundle.main.path(forResource:"add", ofType: "jpeg")!
        let  currentImg = UIImage(contentsOfFile: currentPath)!
        self.doImage.image = UIImage()
        self.doImage.image = currentImg
    }
    
    @IBAction func three(_ sender: Any) {
        doImage.async_maskRadiusImage(chartType: UIView.ChartType.triangle)
        setImage()
    }
    
    @IBAction func five(_ sender: Any) {
        doImage.async_maskRadiusImage(chartType: UIView.ChartType.pentagon)
        setImage()
    }
    
    @IBAction func six(_ sender: Any) {
        doImage.async_maskRadiusImage(chartType: UIView.ChartType.regularHexagon)
        setImage()
    }
    
    @IBAction func fiveStare(_ sender: Any) {
        doImage.async_maskRadiusImage(chartType: UIView.ChartType.diamond)
        setImage()
    }
    
    @IBAction func circle(_ sender: Any) {
        doImage.async_maskRadiusImage(chartType: UIView.ChartType.circular)
        setImage()
    }
    
}
