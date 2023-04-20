//
//  urlWeb.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class urlWeb: UIViewController{
    //Webview viewcontroller
    
    @IBOutlet var urlWebView: WKWebView!
    @IBOutlet var activity: UIActivityIndicatorView!
    var urlPass = ""
    var tool = tools()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        //Setup URL for webview
        print("urlPass: \(urlPass)")
        let url: URL = URL(string: urlPass)!
        let request: URLRequest = URLRequest(url: url)
        print("request: \(request)")
        urlWebView.load(request)
    } 
    
}

