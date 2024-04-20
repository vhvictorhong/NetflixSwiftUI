//
//  NetflixHomeView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-15.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var heroProduct: ProductArray.Product? = nil
    @State private var currentUser: UserArray.User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            scrollView
            filterBarView
        }
        .foregroundColor(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
    }
    
    private var filterBarView: some View {
        VStack(spacing: 0) {
            header
                .padding(.horizontal, 16)
            NetflixFilterBarView(
                filters: filters,
                selectedFilter: selectedFilter) { newFilter in
                    selectedFilter = newFilter
                } onXMarkPressed: {
                    selectedFilter = nil
                }.padding(.top, 16)
        }
        .background(Color.blue)
        .readingFrame { frame in
            fullHeaderSize = frame.size
        }
    }
    
    private var scrollView: some View {
        ScrollView(.vertical) {
            VStack(spacing: 8) {
                Rectangle()
                    .opacity(0)
                    .frame(height: fullHeaderSize.height)
                if let heroProduct {
                    heroCell(product: heroProduct)
                }
                movieCells
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func heroCell(product: ProductArray.Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: [
                product.category.capitalized,
                product.brand]) {
                    
                } onPlayPressed: {
                    
                } onMyListPressed: {
                    
                }
                .padding(24)
    }
    
    private var movieCells: some View {
        LazyVStack(spacing: 16) {
            ForEach(Array(productRows.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title)
                        .font(.headline)
                        .padding(.horizontal, 16)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id: \.offset) { (index, product) in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRanking: rowIndex == 1 ? (index + 1) : nil
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
    private func getData() async {
        guard productRows.isEmpty else { return }
        
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
            heroProduct = products.first
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({ $0.brand }))
            for brand in allBrands {
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
        } catch {
            
        }
    }
}

#Preview {
    NetflixHomeView()
}
