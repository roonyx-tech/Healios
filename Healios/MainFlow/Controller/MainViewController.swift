//
//  MainViewController.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import UIKit
import WebKit

class MainViewContorller: UIViewController, ViewHolder, MainModule {
    typealias RootViewType = MainView
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.webView.load(URLRequest(url: URL(string: "http://weshop.smartideagroup.kz")!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}
