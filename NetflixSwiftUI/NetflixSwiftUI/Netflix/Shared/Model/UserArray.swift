//
//  UserArray.swift
//  NetflixSwiftUI
//
//  Created by Victor Hong on 2024-04-16.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
    
    struct User: Codable, Identifiable {
        let id: Int
        let firstName, lastName: String
        let age: Int
        let email, phone, username, password: String
        let image: String
        let height: Int
        let weight: Double
    }
}
