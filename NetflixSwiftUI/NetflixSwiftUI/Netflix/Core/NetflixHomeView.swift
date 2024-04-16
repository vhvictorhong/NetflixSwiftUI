//
//  NetflixHomeView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-15.
//

import SwiftUI

struct NetflixHomeView: View {
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 16)
                Spacer()
            }
        }.foregroundColor(.netflixWhite)
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        <#code#>
                    }
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        <#code#>
                    }
            }.font(.title2)
        }
    }
}

#Preview {
    NetflixHomeView()
}
