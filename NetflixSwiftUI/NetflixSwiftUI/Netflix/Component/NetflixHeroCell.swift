//
//  NetflixHeroCell.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-16.
//

import SwiftUI
import SwiftfulUI

struct NetflixHeroCell: View {
    
    var imageName: String = Constants.randomImage
    var isNetflixFilm: Bool = true
    var title: String = "Players"
    var categories: [String] = ["Raunchy", "Romantic", "Comedy"]
    var onBackgroundPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundImage
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    if isNetflixFilm {
                        netflixFilm
                    }
                    titleText
                }
                categoriesView
                buttonsView
            }
            .padding(24)
            .background(
                LinearGradient(
                    colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4)
                    ],
                    startPoint: .top,
                    endPoint: .bottom)
            )
        }
        .foregroundStyle(.netflixWhite)
        .cornerRadius(10)
        .aspectRatio(0.8, contentMode: .fit)
        .asButton(.tap) {
            onBackgroundPressed?()
        }
    }
    
    private var backgroundImage: some View {
        ImageLoaderView(urlString: imageName,
                        resizingMode: .fill)
    }
    
    private var netflixFilm: some View {
        HStack(spacing: 8) {
            Text("N")
                .foregroundStyle(.netflixRed)
                .font(.largeTitle)
                .fontWeight(.black)
            Text("FILM")
                .kerning(3)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.netflixWhite)
        }
    }
    
    private var titleText: some View {
        Text(title)
            .font(.system(
                size: 50,
                weight: .medium,
                design: .serif))
    }
    
    private var categoriesView: some View {
        HStack(spacing: 8) {
            ForEach(categories, id: \.self) { category in
                Text(category)
                    .font(.callout)
                if category != categories.last {
                    Circle()
                        .frame(width: 4, height: 4)
                }
            }
        }
    }
    
    private var buttonsView: some View {
        HStack(spacing: 16) {
            playButton
            listButton
        }
        .padding(.horizontal, 16)
        .font(.callout)
        .fontWeight(.medium)
    }
    
    private var playButton: some View {
        HStack {
            Image(systemName: "play.fill")
            Text("Play")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .foregroundStyle(.netflixDarkGray)
        .background(.netflixWhite)
        .cornerRadius(4)
        .asButton(.press) {
            onPlayPressed?()
        }
    }
    
    private var listButton: some View {
        HStack {
            Image(systemName: "plus")
            Text("My List")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .foregroundStyle(.netflixWhite)
        .background(.netflixDarkGray)
        .cornerRadius(4)
        .asButton(.press) {
            onPlayPressed?()
        }
    }
}

#Preview {
    NetflixHeroCell()
        .padding(40)
}
