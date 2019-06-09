//
//  UIImage+FQAddLogo.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/5/6.
//  Copyright © 2019 IamTheHeroYasuo. All rights reserved.
//

import UIKit

public extension UIImage{
    
    /**
     *  图片上加图片
     *
     *  @param addImgae 添加的图片
     *
     *  @param frame 需要添加的尺寸
     */
    ///图片上加图片   如果添加的图片的位置超出了原图片的区域  自动裁剪
    func composeImageWithImage(addImgae:UIImage,frame:CGRect,alpha:CGFloat?=1) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false,self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        addImgae.draw(in: frame, blendMode: CGBlendMode.normal, alpha: alpha!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    
    /// 图片加富文本水印
    ///
    /// - Parameters:
    ///   - attributedStr: 水印完整富文本
    ///   - corner: 水印位置
    ///   -  margin  水印边距
    /// - Returns: 水印图片
    
    enum WaterMarkCorner:String {
        case TopLeft
        case TopRight
        case BottomLeft
        case BottomRight
    }
    
    func drawTextInImage(attributedStr:NSAttributedString,corner:WaterMarkCorner = .BottomRight,margin:CGPoint? = CGPoint(x: 20, y: 20)) ->UIImage{
        let textSize = attributedStr.size()
        var textFrame = CGRect(x: 0, y: 0, width: textSize.width, height: textSize.height)
        let imageSize = self.size
        switch corner{
        case .TopLeft:
            textFrame.origin = margin!
        case .TopRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin!.x, y: margin!.y)
        case .BottomLeft:
            textFrame.origin = CGPoint(x: margin!.x, y: imageSize.height - textSize.height - margin!.y)
        case .BottomRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin!.x, y: imageSize.height - textSize.height - margin!.y)
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        // 图形重绘
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        // 绘制文字
        attributedStr.draw(in: textFrame)
        // 从当前上下文获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    enum ComposeImageEnum:String{
        case leftCenter
        case rightCenter
        case bottomCenter
        case topCenter
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    enum ComposeImageAutoEnum:String{
        case current
        case add
        case normal
    }
    
    /// 两张图片拼接
    ///
    /// - Parameters:
    ///   - addImage: 拼接图片
    ///   - corner: 拼接图片方位
    ///   -  margin  图片边距
    ///  -  isAutoDraw  当图片拼接时高宽不一致 是否把图片尺寸 按其中某张图片拉伸
    /// - Returns: 拼接图片
    func composeOutsideImgaeInImage(addImage:UIImage,corner:ComposeImageEnum,margin:CGFloat? = 0 ) -> UIImage{
//        var currentImg = self
//        var addImage = addImage;
        var currentWidth = self.size.width
        var currentHeight = self.size.height
        var addHeight = addImage.size.height
        var addWidth = addImage.size.width
        
        var offScreenSize = CGSize.zero
        var currentRect = CGRect.zero
        var addRect = CGRect.zero
        let absHeightValue:CGFloat = fabs(currentHeight - addHeight)/2
        let absWidthValue:CGFloat = fabs(currentWidth - addWidth)/2
//        if isAutoDraw == ComposeImageAutoEnum.normal{
//
//        }else if isAutoDraw == ComposeImageAutoEnum.add{
//            switch corner {
//            case .leftCenter,.leftTop,.leftBottom,.rightTop,.rightBottom,.rightCenter:
//                let scale = currentHeight/addHeight
//                currentWidth = currentWidth/scale
//                currentHeight = addHeight
//
//            case .bottomCenter,.bottomLeft,.bottomRight,.topLeft,.topRight,.topCenter:
//                let scale = currentWidth/addWidth
//                currentHeight = currentHeight/scale
//                currentWidth = addWidth
//            }
//        }else if isAutoDraw == ComposeImageAutoEnum.current{
//            switch corner {
//            case .leftCenter,.leftTop,.leftBottom,.rightTop,.rightBottom,.rightCenter:
//                let scale = currentHeight/addHeight
//                addWidth = addWidth*scale
//                addHeight = currentHeight
//
//            case .bottomCenter,.bottomLeft,.bottomRight,.topLeft,.topRight,.topCenter:
//                let scale = currentWidth/addWidth
//                addHeight = addHeight*scale
//                addWidth = currentWidth
//            }
//
//        }
    
//        currentImg = currentImg.reSizeImage(reSize: CGSize(width: currentWidth, height: currentHeight))
//        addImage = addImage.reSizeImage(reSize: CGSize(width: addWidth, height: addHeight))
        
        switch corner{
        case .leftCenter:
            addRect = CGRect(x: 0, y: (currentHeight>addHeight ? absHeightValue:0), width: addWidth, height: addHeight)
            currentRect = CGRect(x: addWidth + margin!, y: (currentHeight>addHeight ? 0:absHeightValue), width: currentWidth, height: currentHeight)
        case .rightCenter:
            addRect = CGRect(x: currentWidth + margin!, y: (currentHeight>addHeight ? absHeightValue:0), width: addWidth, height: addHeight)
            currentRect = CGRect(x: 0, y: (currentHeight>addHeight ? 0:absHeightValue), width: currentWidth, height: currentHeight)
        case .bottomCenter:
            addRect = CGRect(x: (currentWidth>addWidth ? absWidthValue:0), y: currentHeight+margin!, width: addWidth, height: addHeight)
            currentRect = CGRect(x: (currentWidth>addWidth ? 0:absWidthValue), y: 0, width: currentWidth, height: currentHeight)
        case .topCenter:
            addRect = CGRect(x: (currentWidth>addWidth ? absWidthValue:0), y: 0, width: addWidth, height: addHeight)
            currentRect = CGRect(x: (currentWidth>addWidth ? 0:absWidthValue), y: addHeight+margin!, width: currentWidth, height: currentHeight)
        case .leftTop:
            addRect = CGRect(x: 0, y: 0, width: addWidth, height: addHeight)
            currentRect = CGRect(x: addWidth + margin!, y: 0, width: currentWidth, height: currentHeight)
        case .leftBottom:
            addRect = CGRect(x: 0, y: (currentHeight>addHeight ? absHeightValue*2:0), width: addWidth, height: addHeight)
            currentRect = CGRect(x: addWidth + margin!, y: (currentHeight>addHeight ? 0:absHeightValue*2), width: currentWidth, height: currentHeight)
        case .rightTop:
            addRect = CGRect(x: currentWidth + margin!, y: 0, width: addWidth, height: addHeight)
            currentRect = CGRect(x: 0, y: 0, width: currentWidth, height: currentHeight)
        case .rightBottom:
            addRect = CGRect(x: currentWidth + margin!, y: (currentHeight>addHeight ? absHeightValue*2:0), width: addWidth, height: addHeight)
            currentRect = CGRect(x: 0, y: (currentHeight>addHeight ? 0:absHeightValue*2), width: currentWidth, height: currentHeight)
        case .topLeft:
            addRect = CGRect(x: (currentWidth>addWidth ? absWidthValue:0), y: 0, width: addWidth, height: addHeight)
            currentRect = CGRect(x: (currentWidth>addWidth ? 0:absWidthValue), y: addHeight+margin!, width: currentWidth, height: currentHeight)
        case .topRight:
            addRect = CGRect(x: (currentWidth>addWidth ? absWidthValue*2:0), y: 0, width: addWidth, height: addHeight)
            currentRect = CGRect(x: (currentWidth>addWidth ? 0:absWidthValue*2), y: addHeight+margin!, width: currentWidth, height: currentHeight)
        case .bottomLeft:
            addRect = CGRect(x:0, y: currentHeight+margin!, width: addWidth, height: addHeight)
            currentRect = CGRect(x: 0, y: 0, width: currentWidth, height: currentHeight)
        case .bottomRight:
            addRect = CGRect(x: (currentWidth>addWidth ? absWidthValue*2:0), y: currentHeight+margin!, width: addWidth, height: addHeight)
            currentRect = CGRect(x: (currentWidth>addWidth ? 0:absWidthValue), y: 0, width: currentWidth, height: currentHeight)
        }

        switch corner {
        case .leftCenter:
            offScreenSize.width = currentWidth + margin! + addWidth
            offScreenSize.height = max(currentHeight, addHeight)
        case .rightCenter:
            offScreenSize.width = currentWidth + margin! + addWidth
            offScreenSize.height = max(currentHeight, addHeight)
        case .bottomCenter:
            offScreenSize.height = currentHeight + margin! + addHeight
            offScreenSize.width = max(currentWidth, addWidth)
        case .topCenter:
            offScreenSize.height = currentHeight + margin! + addHeight
            offScreenSize.width = max(currentWidth, addWidth)
        case .leftTop:
            offScreenSize.width = currentWidth + margin! + addWidth
            offScreenSize.height = max(currentHeight, addHeight)
        case .leftBottom:
            offScreenSize.width = currentWidth + margin! + addWidth
            offScreenSize.height = max(currentHeight, addHeight)
        case .rightTop:
            offScreenSize.width = currentWidth + margin! + addWidth
            offScreenSize.height = max(currentHeight, addHeight)
        case .rightBottom:
            offScreenSize.width = currentWidth + margin! + addWidth
            offScreenSize.height = max(currentHeight, addHeight)
        case .topLeft:
            offScreenSize.height = currentHeight + margin! + addHeight
            offScreenSize.width = max(currentWidth, addWidth)
        case .topRight:
            offScreenSize.height = currentHeight + margin! + addHeight
            offScreenSize.width = max(currentWidth, addWidth)
        case .bottomLeft:
            offScreenSize.height = currentHeight + margin! + addHeight
            offScreenSize.width = max(currentWidth, addWidth)
        case .bottomRight:
            offScreenSize.height = currentHeight + margin! + addHeight
            offScreenSize.width = max(currentWidth, addWidth)
            
        }
        UIGraphicsBeginImageContextWithOptions(offScreenSize, false, offScreenSize.width/offScreenSize.height);
        self.draw(in: currentRect)
        addImage.draw(in: addRect)
        let backImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return backImage
    }
    
    
}






extension UIImage {

    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}
