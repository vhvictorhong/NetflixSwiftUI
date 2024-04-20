//
//  ProductRow.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-19.
//

import Foundation

struct ProductRow: Identifiable {
    let id: UUID = UUID()
    let title: String
    let products: [ProductArray.Product]
}
