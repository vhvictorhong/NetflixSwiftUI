//
//  DatabaseHelper.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-16.
//

import Foundation

struct DatabaseHelper {
    
    func getProducts() async throws -> [ProductArray.Product] {
        
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let productArray = try JSONDecoder().decode(ProductArray.self, from: data)
        
        return productArray.products
    }
    
    func getUsers() async throws -> [UserArray.User] {
        
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let userArray = try JSONDecoder().decode(UserArray.self, from: data)
        
        return userArray.users
    }
}
