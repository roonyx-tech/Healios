//
//  MainView.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import UIKit
import WebKit

class MainView: UIView {
    
    let webView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureView() {
        backgroundColor = .white
    }
}

