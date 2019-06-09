//
//  FQWkWebVC.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit
import WebKit
class FQWkWebVC: BaseViewController {

    var wkWebView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func initSubVCs() {
        wkWebView = WKWebView(frame: view.bounds)
        wkWebView.navigationDelegate = self
        wkWebView.backgroundColor = UIColor.white
        view.addSubview(wkWebView)
        
        let urlStr = "https://www.meituan.com"
        let request = URLRequest(url: URL.init(string: urlStr)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        wkWebView.load(request)
        
        shotView = wkWebView
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }

}
extension FQWkWebVC:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startAnimation()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopAnimation()
    }
}
