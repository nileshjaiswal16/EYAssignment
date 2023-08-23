//
//  LazyReleaseableImageView.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 22/08/23.
//


import SwiftUI
import SDWebImageSwiftUI

public struct LazyReleaseableWebImage<T: View>: View {
    
    @State
    private var shouldShowImage: Bool = false
    
    private let content: () -> WebImage
    private let placeholder: () -> T
    
    public init(@ViewBuilder content: @escaping () -> WebImage,
                @ViewBuilder placeholder: @escaping () -> T) {
        self.content = content
        self.placeholder = placeholder
    }
    
    public var body: some View {
        ZStack {
            if shouldShowImage {
                content()
            } else {
                placeholder()
            }
        }
        .onAppear {
            shouldShowImage = true
        }
        .onDisappear {
            shouldShowImage = false
        }
    }
}

