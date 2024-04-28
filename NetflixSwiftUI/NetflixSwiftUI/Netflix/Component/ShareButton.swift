//
//  ShareButton.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-27.
//

import SwiftUI

struct ShareButton: View {
    
    var url: String = "https://www.google.com"
    
    var body: some View {
        if let url = URL(string: url) {
            ShareLink(item: url) {
                VStack(spacing: 8) {
                    Image(systemName: "hand.thumbsup")
                        .font(.title)
                            
                    Text("Rate")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(Color.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ShareButton()
    }
}
