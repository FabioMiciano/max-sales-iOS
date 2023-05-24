//
//  WebViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 27/02/23.
//

import Foundation
import UIKit
import WebKit

final class WebViewController: UIViewController {
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
    
    func setup(title: String, path: String) {
        guard let url = URL(string: path) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        self.title = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension WebViewController: ViewConfiguration {
    func createHyerarchy() {
        view.addSubview(webView)
    }
    
    func setupConstraints() {
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
