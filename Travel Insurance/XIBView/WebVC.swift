//
//  WebVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 03/02/24.
//

import UIKit
import WebKit

class WebVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    var strTitle = ""
    var strUrl = ""
    
    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = strTitle
        
        webView = WKWebView()
        DispatchQueue.main.async {
            self.webView.frame = CGRect.init(x: 0, y: 0, width: self.mainView.frame.size.width, height: self.mainView.frame.size.height)
            
            self.webView.load(NSURLRequest(url: URL(string: self.strUrl)! as URL) as URLRequest)
            
            self.webView.allowsBackForwardNavigationGestures = true
            
            self.webView.navigationDelegate = self
            
            self.webView.scrollView.bounces = false
            
            self.mainView.addSubview(self.webView)
        }

        // Do any additional setup after loading the view.
    }
   
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        APIClient.sharedInstance.showIndicator()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        APIClient.sharedInstance.hideIndicator()
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        APIClient.sharedInstance.hideIndicator()
        print(error)
    }
    
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
