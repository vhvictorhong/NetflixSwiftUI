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
                    VStack(spacing: 16) {
                        NetflixDetailsProductView(title: product.title, isNew: true, yearReleased: "2024", seasonCount: 4, hasClosedCaption: true, isTopTen: 6, descriptionText: product.description, castText: "Cast: Victor, Your Name, Someone Else") {
                            
                        } onDownloadPressed: {
                            
                        }

                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    NetflixMovieDetailsView()
}
