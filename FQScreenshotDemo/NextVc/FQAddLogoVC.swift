//
//  FQAddLogoVC.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/5/15.
//  Copyright © 2019 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class FQAddLogoVC: UIViewController {

    var currentPath = ""
    var addPath = ""
    var currentImg = UIImage()
    var addImg = UIImage()
    var text = "水印文字"
    var attriStr : NSMutableAttributedString = NSMutableAttributedString()
    
    @IBOutlet weak var composeImage: UIImageView!
    @IBOutlet weak var finshImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        self.setAttrStr()
        
    }
    
    func initData()
    {
        //        1、从文件目录中获取图片
        currentPath = Bundle.main.path(forResource:"current", ofType: "jpg")!
        
        addPath = Bundle.main.path(forResource:"add", ofType: "jpeg")!
        currentImg = UIImage(contentsOfFile: currentPath)!
        addImg = UIImage(contentsOfFile: addPath)!
        
    }
    
    func setAttrStr(){
        let wo = NSAttributedString.init(string: "我", attributes: [NSAttributedString.Key.backgroundColor : UIColor.gray , NSAttributedString.Key.foregroundColor : UIColor.green , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        
        let shi : NSAttributedString = NSAttributedString(string: "是", attributes: [NSAttributedString.Key.foregroundColor  : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
        
        //帅逼
        let shuaibi : NSAttributedString = NSAttributedString(string: "帅逼", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 38)])
        attriStr.append(wo)
        attriStr.append(shi)
        attriStr.append(shuaibi)
    }

    @IBAction func addImg(_ sender: Any) {

        
        self.finshImg.image = currentImg.composeImageWithImage(addImgae: addImg, frame: CGRect(x: 0, y: 0, width:100, height:100), alpha: 1);
    }
    
    @IBAction func addText(_ sender: Any) {
        
        let image = self.finshImg.image?.drawTextInImage(attributedStr: attriStr, corner: UIImage.WaterMarkCorner.BottomLeft, margin: CGPoint(x: 20, y: 20))
        self.finshImg.image = image
    }
    
    @IBAction func composeImg(_ sender: Any) {        
        self.composeImage.image = self.finshImg.image?.composeOutsideImgaeInImage(addImage: self.addImg, corner: UIImage.ComposeImageEnum.rightCenter
            , margin: 20)
    }

}


