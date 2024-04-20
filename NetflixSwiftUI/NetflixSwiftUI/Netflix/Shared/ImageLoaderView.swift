//
//  ImageLoaderView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-16.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                imageView(resizingMode: resizingMode)
            }.clipped()
    }
    
    private func imageView(resizingMode: ContentMode) -> some View {
        WebImage(url: URL(string: urlString))
            .resizable()
            .indicator(.activity)
            .aspectRatio(contentMode: resizingMode)
            .allowsHitTesting(false)
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
