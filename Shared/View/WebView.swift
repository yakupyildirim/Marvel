//
//  WebView.swift
//  SwiftUICombine (iOS)
//
//  Created by Yakup Yıldırım on 1.12.2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    
    }
}

