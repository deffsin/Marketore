//
//  Product.swift
//  Marketore
//
//  Created by Denis Sinitsa on 21.02.2024.
//

import SwiftUI

struct Product: Codable {
    let id: UUID
    let userId: UUID
    let userFullname: String
    let title: String
    let description: String
    let category: String
    let subcategory: String
    let location: String
}
