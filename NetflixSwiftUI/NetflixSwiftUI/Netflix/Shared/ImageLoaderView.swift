//
//  ImageLoaderView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-16.
//

import SwiftUI

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
        AsyncImage(url: URL(string: urlString),
                   scale: 3) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color.gray
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: resizingMode)
            case .failure(_):
                Image(systemName: "photo.fill")
            @unknown default:
                Image(systemName: "photo.fill")
            }
        }.allowsHitTesting(false)
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
