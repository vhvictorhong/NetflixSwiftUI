//
//  NetflixHomeView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-15.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    
    @State private var showProduct = false
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var scrollViewOffset: CGFloat = 0
    
    @State private var heroProduct: ProductArray.Product? = nil
    @State private var currentUser: UserArray.User? = nil
    @State private var productRows: [ProductRow] = []
    @State private var selectProduct: ProductArray.Product? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            gradientView
            scrollView
            filterBarView
        }
        .foregroundColor(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showProduct, content: {
            if let selectProduct {
                NetflixMovieDetailsView(isPresented: $showProduct, product: selectProduct)
            }
        })
    }
    
    private var gradientView: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .netflixDarkGray.opacity(
                        1
                    ),
                    .netflixDarkGray.opacity(
                        0
                    )
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            LinearGradient(
                colors: [
                    .netflixDarkRed.opacity(
                        0.5
                    ),
                    .netflixDarkRed.opacity(
                        0
                    )
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, (400 + (scrollViewOffset * 0.75))))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
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
            if scrollViewOffset > -20 {
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter) { newFilter in
                        selectedFilter = newFilter
                    } onXMarkPressed: {
                        selectedFilter = nil
                    }
                    .padding(.top, 16)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
        }
    }
    
    private var scrollView: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false
        ) {
            VStack(spacing: 8) {
                Rectangle()
                    .opacity(0)
                    .frame(height: fullHeaderSize.height)
                if let heroProduct {
                    heroCell(product: heroProduct)
                }
                movieCells
            }
        } onScrollChanged: { offset in
            scrollViewOffset = min(0, offset.y)
        }
    }
    
    private func heroCell(product: ProductArray.Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: [
                product.category.capitalized,
                product.brand]) {
                    selectProduct = product
                    showProduct = true
                } onPlayPressed: {
                    selectProduct = product
                    showProduct = true
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
                                .onTapGesture {
                                    selectProduct = product
                                    showProduct = true
                                }
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
                rows.append(ProductRow(title: brand.capitalized, products: products.shuffled()))
            }
            productRows = rows
        } catch {
            
        }
    }
}

#Preview {
    NetflixHomeView()
}
