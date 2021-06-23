//
//  MainViewController.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import UIKit
import WebKit
import RxSwift

class MainViewContorller: UIViewController, ViewHolder, MainModule, WKNavigationDelegate {
    var loginTapped: Callback?
    typealias RootViewType = MainView
    
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    private let userSessionStorage: UserSessionStorage
    private var urlrequestCurrent: URLRequest?
    
    init(viewModel: MainViewModel, userSessionStorage: UserSessionStorage) {
        self.viewModel = viewModel
        self.userSessionStorage = userSessionStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://weshop.smartideagroup.kz")
        let request = URLRequest(url: url!)
        rootView.webView.load(request)
        rootView.webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("WEB decidePolicyFor navigationAction: \(navigationAction)")
        var token = userSessionStorage.accessToken
        let currentURL = navigationAction.request.url?.absoluteString
        if currentURL == "https://weshop.smartideagroup.kz/auth/login" && token == nil {
            loginTapped?()
        }
        if currentURL == "http://weshop.smartideagroup.kz/site/logout" || currentURL == "https://weshop.smartideagroup.kz/site/logout" {
            userSessionStorage.accessToken = nil
            loginTapped?()
        }
        if let currentrequest = self.urlrequestCurrent {
            print("currentrequest: \(currentrequest), navigationAction.request: \(navigationAction.request)")
            if currentrequest == navigationAction.request {
                self.urlrequestCurrent = nil
                decisionHandler(.allow)
                return
            }
        }

        decisionHandler(.cancel)
        
        if (currentURL == "http://weshop.smartideagroup.kz/cabinet" || currentURL == "https://weshop.smartideagroup.kz/cabinet")  && token == nil {
            loginTapped?()
        }
        var customRequest = navigationAction.request
        if token != nil {
            customRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        }
        self.urlrequestCurrent = customRequest
        webView.load(customRequest)
    }
    
}
