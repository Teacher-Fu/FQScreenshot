//
//  FQShoutManger.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/5/9.
//  Copyright © 2019 IamTheHeroYasuo. All rights reserved.
//

import UIKit
import WebKit
internal typealias imageBackBlock = ((UIImage) -> Void )
internal typealias VoidBlock = (() -> Void)

public class FQShoutManger: NSObject {
    static let share = FQShoutManger()
    
    func screenShot(_ shotView:UIView,finisBlocck:imageBackBlock?){
        if shotView.isKind(of: WKWebView.self){
            let wkWebView = shotView as! WKWebView
            wkWebView.screenShot { (shotImage) in
                if finisBlocck != nil{
                    finisBlocck?(shotImage)
                }
            }
        }else if shotView.isKind(of: UIWebView.self){
            let webView = shotView as! UIWebView
            webView.scrollView .screenShot { (shotImage) in
                if finisBlocck != nil{
                    finisBlocck?(shotImage)
                }
            }
        }else if shotView.isKind(of: UIScrollView.self) || shotView.isKind(of: UITableView.self) || shotView.isKind(of: UICollectionView.self){
            let scrollView = shotView as! UIScrollView
            scrollView.screenShot { (shotImage) in
                if finisBlocck != nil{
                    finisBlocck?(shotImage)
                }
            }
        }else if shotView.isKind(of: UIView.self){
            let uiView = shotView
            uiView.viewScreenShot { (shotImage) in
                if finisBlocck != nil{
                    finisBlocck?(shotImage)
                }
            }
        }else{
            print("不支持的类型")
        }
    }
    

    
    
    /// 多张图片拼接
    ///
    /// - Parameters:
    ///   - images: 拼接图片数组
    ///   - bgImage: 拼接图片背景图
    ///   -  imageRect  图片位置
    /// - Returns: 拼接图片
    public func composeImageWithImage(bgImage: UIImage? = UIImage(),
                                      imageRect: [CGRect],
                                      images:[UIImage]) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bgImage!.size, false, bgImage!.scale);
        let bgRect = CGRect(x: 0, y: 0, width: bgImage!.size.width, height: bgImage!.size.height)
        bgImage!.draw(in:bgRect)
        for (index,item) in images.enumerated(){
            if index > imageRect.count{
                print("imageRect is not match to images's count ")
                break
            }
            item.draw(in: imageRect[index])
            
        }
        let backImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return backImage
    }
    
    
    /// 多张图片拼接
    ///
    /// - Parameters:
    ///   - image: 画圆图片
    ///   - radius: 半径
    ///   -  fillColor  填充颜色
    /// - completion: 返回图片回调
    public func async_maskRadiusImage(image:UIImage,radius:CGFloat!,fillColor: UIColor! = UIColor.clear,completion:@escaping ((_ image:UIImage)->Void)){
        //异步绘制裁切
        DispatchQueue.global().async {
            //利用绘图建立上下文
            UIGraphicsBeginImageContextWithOptions(image.size, true, 0)
            
            let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            
            //设置填充颜色
            fillColor.setFill()
            UIRectFill(rect)
            
            //利用贝塞尔路径裁切
            var tempRadius = radius
            if tempRadius == nil{
                tempRadius = image.size.width/2
            }
            
            let path = UIBezierPath.init(roundedRect: rect, cornerRadius: tempRadius!)
            path.addClip()
            
            image.draw(in: rect)
            
            //获取结果
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            
            //关闭上下文
            UIGraphicsEndImageContext()
            
            //主队列回调
            DispatchQueue.main.async {
                completion(resultImage!)
            }
        }
    }
    

}


