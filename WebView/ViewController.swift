//
//  ViewController.swift
//  WebView
//
//  Created by toonan on 2017/10/30.
//  Copyright © 2017年 leophy. All rights reserved.
//

import UIKit
import KRProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var forwardItem: UIBarButtonItem!
    @IBOutlet weak var refreshItem: UIBarButtonItem!
    @IBOutlet weak var homeItem: UIBarButtonItem!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        KRProgressHUD.show()
        
        getRemoteUrl { url in
            self.webView.loadRequest(URLRequest(url: url))
        }
    }
}

extension ViewController {
    @IBAction func back() {
        if webView.canGoBack {
            self.webView.goBack()
        }
    }
    
    @IBAction func forward() {
        if webView.canGoForward {
            self.webView.goForward()
        }
    }
    
    @IBAction func refresh() {
        webView.reload()
    }
    
    @IBAction func home() {
        webView.loadRequest(URLRequest(url: getLocalUrl()))
    }
}

extension ViewController : UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        KRProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        backItem.isEnabled = webView.canGoBack
        forwardItem.isEnabled = webView.canGoForward
        KRProgressHUD.showSuccess()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        KRProgressHUD.showError()
    }
}

