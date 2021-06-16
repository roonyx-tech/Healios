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
        if userSessionStorage.accessToken == nil {
            rootView.webView.load(URLRequest(url: URL(string: "http://weshop.smartideagroup.kz")!))
        } else {
            bindView()
        }
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
    
    private func bindView() {
        let output = viewModel.transform(input: .init(viewDidLoad: .just(())))
        
        let res = output.res.publish()
        
        res.element
            .subscribe(onNext: { [unowned self] res in
                
            }).disposed(by: disposeBag)
        
        res.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        res.connect()
            .disposed(by: disposeBag)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.request.isHttpLink else {
            decisionHandler(.allow)
            let currentURL = navigationAction.request.url?.absoluteString
            if currentURL == "http://weshop.smartideagroup.kz/auth/login" {
                loginTapped?()
            }
            return
        }
    }
    
}

extension URLRequest {
    var isHttpLink: Bool {
        return self.url?.scheme?.contains("http://weshop.smartideagroup.kz/auth/login") ?? false
    }
}
