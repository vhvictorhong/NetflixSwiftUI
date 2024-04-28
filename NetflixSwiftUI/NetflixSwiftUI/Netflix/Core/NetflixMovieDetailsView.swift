//
//  NetflixMovieDetailsView.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-26.
//

import SwiftUI

struct NetflixMovieDetailsView: View {
    
    @Binding var isPresented: Bool
    
    @State private var showProduct = false
    
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [ProductArray.Product] = []
    @State private var selectProduct: ProductArray.Product? = nil
    
    var product: ProductArray.Product = .mock
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            VStack(spacing: 0) {
                headerVideoView
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        detailProductView
                        buttonsView
                        similarView
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
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
    
    private var headerVideoView: some View {
        NetflixDetailsHeaderView(imageName: product.firstImage, progress: progress) {
            
        } onXMarkPressed: {
            isPresented = false
        }
    }
    
    private var detailProductView: some View {
        NetflixDetailsProductView(title: product.title, isNew: true, yearReleased: "2024", seasonCount: 4, hasClosedCaption: true, isTopTen: 6, descriptionText: product.description, castText: "Cast: Victor, Your Name, Someone Else") {
            
        } onDownloadPressed: {
            
        }
    }
    
    private var buttonsView: some View {
        HStack(spacing: 32) {
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            RateButton { selection in
                // do something with selection
            }
            ShareButton()
        }
        .padding(.leading, 32)
    }
    
    private var similarView: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)
            LazyVGrid(columns: Array(
                repeating: GridItem(
                    .flexible(),
                    spacing: 8
                ),
                count: 3
            ),
                      alignment: .center,
                      spacing: 8,
                      pinnedViews: [],
                      content: {
                ForEach(
                    products
                ) { product in
                    NetflixMovieCell(
                        imageName: product.firstImage,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded,
                        topTenRanking: nil
                    )
                    .onTapGesture {
                        selectProduct = product
                        showProduct = true
                    }
                }
            })
        }
        .foregroundStyle(.netflixWhite)
    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
}

#Preview {
    NetflixMovieDetailsView(isPresented: .constant(false))
}
