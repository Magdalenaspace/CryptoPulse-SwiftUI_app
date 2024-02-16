//
//  LazyNavigationView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//


import SwiftUI

struct LazyNavigationView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
