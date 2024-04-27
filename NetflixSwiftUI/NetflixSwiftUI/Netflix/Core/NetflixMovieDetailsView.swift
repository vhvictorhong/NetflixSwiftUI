//
//  NetflixMovieDetailsView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-26.
//

import SwiftUI

struct NetflixMovieDetailsView: View {
    
    @State private var progress: Double = 0.2
    
    var product: ProductArray.Product = .mock
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            VStack(spacing: 0) {
                NetflixDetailsHeaderView(imageName: product.firstImage, progress: progress) {
                    
                } onXMarkPressed: {
                    
                }
                ScrollView(.vertical) {
                    
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    NetflixMovieDetailsView()
}
