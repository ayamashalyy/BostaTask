//
//  User.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let address: Address
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

