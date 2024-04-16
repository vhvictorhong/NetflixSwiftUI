//
//  NetflixFilterCell.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-15.
//

import SwiftUI

struct NetflixFilterCell: View {
    
    var title: String = "Categories"
    var isDropdown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            if isDropdown {
                Image(systemName: "chevron.down")
            }
        }.padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                ZStack {
                    if isSelected {
                        Capsule(style: .circular)
                            .fill(.netflixDarkGray)
                    } else {
                        Capsule(style: .circular)
                            .stroke(lineWidth: 1)
                    }
                }
            )
            .foregroundColor(.netflixLightGray)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            NetflixFilterCell()
            NetflixFilterCell(isDropdown: false)
            NetflixFilterCell(isSelected: true)
        }
    }
}
