//
//  FQWebVC.swift
//  FQScreenshotDemo
//
//  Created by 付强 on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class FQWebVC: BaseViewController {
    
    var webView:UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

    override func initSubVCs() {
        webView = UIWebView(frame: view.bounds)
        webView.delegate = self
        self.webView.delegate = self;
        self.webView.scalesPageToFit = true
        self.webView.scrollView.bounces = false
        self.webView.backgroundColor = UIColor.white
        view.addSubview(webView)
       
        let urlStr = "https://www.meituan.com"
        let request = URLRequest(url: URL(string: urlStr)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        webView.loadRequest(request)
        shotView = webView
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
}

extension FQWebVC:UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        startAnimation()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        stopAnimation()
    }
    
}

