//
//  NetflixHeroCell.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-16.
//

import SwiftUI

struct NetflixHeroCell: View {
    
    var imageName: String = Constants.randomImage
    var isNetflixFilm: Bool = true
    var title: String = "Players"
    var categories: [String] = ["Raunchy", "Romantic", "Comedy"]
    var onBackgroundPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil

    var body: some View {
        ZStack {
            
        }
        
    }
}

#Preview {
    NetflixHeroCell()
}
