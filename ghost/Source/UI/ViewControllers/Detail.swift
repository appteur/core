//
//  Detail.swift
//  ghost
//
//  Created by Tomáš Pánik on 28/07/2018.
//  Copyright © 2018 Tomáš Pánik. All rights reserved.
//

import UIKit
import WebKit

class Detail: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var content: WKWebView!
    var result: Ghost? { didSet { configureView() }}
    
    func configureView() {
        if let result = result { title = result.name }}
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureView()
        
        content.uiDelegate = self
        content.navigationDelegate = self
        let url = Bundle.main.url(forResource: result?.id, withExtension: "html", subdirectory: "location".localized)!
        let request = URLRequest(url: url)
        content.loadFileURL(url, allowingReadAccessTo: url)
        content.load(request)   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() }}
