//
//  FQScreenShot.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/15.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit
import WebKit
public typealias imageBackBlock = ((UIImage) -> Void )
public typealias VoidBlock = (() -> Void)
public class FQScreenShot: NSObject {
    public static func screenShot(_ shotView:UIView,finisBlocck:imageBackBlock?){
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
}
