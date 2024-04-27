//
//  NetflixMovieDetailsView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-26.
//

import SwiftUI

struct NetflixMovieDetailsView: View {
    
    var product: ProductArray.Product = .mock
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            VStack(spacing: 0) {
                
            }
        }
    }
}

#Preview {
    NetflixMovieDetailsView()
}
