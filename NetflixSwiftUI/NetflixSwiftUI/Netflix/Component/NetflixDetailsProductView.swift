//
//  NetflixDetailsProductView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-26.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsProductView: View {
    
    var title: String = "Movie Title"
    var isNew: Bool = true
    var yearReleased: String? = "2024"
    var seasonCount: Int? = 2
    var hasClosedCaption: Bool = true
    var isTopTen: Int? = 6
    var descriptionText: String? = "This is the description for the title that is selected and it should go multiple lines."
    var castText: String? = "Cast: Victor, Your Name, Someone Else"
    var onPlayPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            titleView
            subtitleView
            if let isTopTen {
                topTenView
            }
            buttonsView
            groupDescriptionText
        }
        .foregroundStyle(.netflixWhite)
    }
    
    private var titleView: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var subtitleView: some View {
        HStack(spacing: 8) {
            if isNew {
                Text("New")
                    .foregroundStyle(.green)
            }
            if let yearReleased {
                Text(yearReleased)
            }
            if let seasonCount {
                Text("\(seasonCount) Seasons")
            }
            if hasClosedCaption {
                Image(systemName: "captions.bubble")
            }
        }
        .foregroundStyle(.netflixLightGray)
    }
    
    private var topTenView: some View {
        HStack(spacing: 8) {
            Rectangle()
                .fill(.netflixRed)
                .frame(width: 28, height: 28)
                .overlay(
                    VStack(spacing: -4) {
                        Text("TOP")
                            .fontWeight(.bold)
                            .font(.system(size: 8))
                        Text("10")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                    }
                        .offset(y: 1)
                )
            Text("#\(isTopTen ?? 1) in TV Shows today")
                .font(.headline)
        }
    }
    
    private var buttonsView: some View {
        VStack(spacing: 8) {
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
            HStack {
                Image(systemName: "arrow.down.to.line.alt")
                Text("Download")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .foregroundStyle(.netflixWhite)
            .background(.netflixDarkGray)
            .cornerRadius(4)
            .asButton(.press) {
                onDownloadPressed?()
            }
        }
        .font(.callout)
        .fontWeight(.medium)
    }
    
    private var groupDescriptionText: some View {
        Group {
            if let descriptionText {
                Text(descriptionText)
            }
            if let castText {
                Text(castText)
            }
        }
        .font(.callout)
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 40) {
            NetflixDetailsProductView()
            NetflixDetailsProductView(
                isNew: false,
                yearReleased: nil,
                seasonCount: nil,
                hasClosedCaption: false,
                isTopTen: nil,
                descriptionText: nil,
                castText: nil
            )
        }
    }
}
