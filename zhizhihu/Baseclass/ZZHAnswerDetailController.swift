//
//  ZZHAnswerDetailController.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/11.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit
import WebKit

class ZZHAnswerDetailController: ZZHViewController {
    var imgModel:ImageModel?
    let webView = WKWebView()
    var processBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "答案详情"
        let url = "https://www.zhihu.com/question/"+(imgModel?.question_id)!+"/answer/"+(imgModel?.answer_id)!
        
        webView.frame = SCREEN_RECT
        self.view.addSubview(webView)
        self.webView.load(URLRequest.init(url: URL.init(string: url)!))
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.webView.allowsBackForwardNavigationGestures = true
        
        processBar = UIProgressView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        processBar.progress = 0.0
        processBar.tintColor = APP_TITLE_COLOR
        webView.addSubview(processBar)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func viewDidDisappear(_ animated: Bool) {
    //        super.viewDidDisappear(animated)
    //        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    //        print("remove")
    //    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
}

extension ZZHAnswerDetailController:WKNavigationDelegate, WKUIDelegate{
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        HUDTool.showErrorInView(view: self.view, withText: error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        //        self.navigationItem.title = webView.title!
    }
    
    // WKWebView创建初始化加载的一些配置
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?{
        if !(navigationAction.targetFrame != nil){
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    // 处理网页js中的提示框,若不使用该方法,则提示框无效
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void){
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (_) -> Void in
            completionHandler()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // 处理网页js中的确认框,若不使用该方法,则确认框无效
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void){
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            completionHandler(true)
        }))
        alertVC.addAction(UIAlertAction(title: "取消", style: .default, handler: { (_) -> Void in
            completionHandler(false)
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            processBar.alpha = 1
            processBar.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0{
                //                if webView.scrollView.mj_header.isRefreshing(){
                //                    webView.scrollView.mj_header.endRefreshing()
                //                }
                UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseInOut, animations: {
                    self.processBar.alpha = 0
                }, completion: { (_) in
                    self.processBar.progress = 0
                })
            }
        }
    }
    
}

