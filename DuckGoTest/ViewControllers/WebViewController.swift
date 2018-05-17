//
//  WebViewController.swift
//  DuckGoTest
//
//  Created by Raphael Araújo on 2018-05-15.
//  Copyright © 2018 Raphael Araújo. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    var item: DuckGoResultItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        
        if let url = URL(string: item.firstURL!) {
            let request = URLRequest(url: url) 
            self.webView.load(request)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
