//
//  ProductArray.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-16.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
    
    struct Product: Codable, Identifiable {
        let id: Int
        let title, description: String
        let price: Int
        let discountPercentage, rating: Double
        let stock: Int
        let brand, category: String
        let thumbnail: String
        let images: [String]
        
        var firstImage: String {
            images.first ?? Constants.randomImage
        }
        
        let recentlyAdded: Bool = {
            return Int.random(in: 1...4) == 1
        }()
    }
}
