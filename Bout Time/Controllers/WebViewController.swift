//
//  WebViewController.swift
//  Bout Time
//
//  Created by Bradley White on 9/18/17.
//  Copyright © 2017 Bradley White. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var eventURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUrl() {
        if let url: String = eventURL {
            let myURL = URL(string: url)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
    }
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
