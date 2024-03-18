//
//  Product.swift
//  Marketore
//
//  Created by Denis Sinitsa on 21.02.2024.
//

import SwiftUI

struct Product: Codable {
    let productId: String
    let userId: String
    let userFullname: String?
    let title: String
    let description: String
    let price: Int
    let category: String
    let subcategory: String
    let location: String
    let contact: String
    // delivery
    let dataCreated: Date?
    // docId
    
    init(auth: AuthDataResultModel) {
        self.productId = ""
        self.userId = auth.uid
        self.userFullname = auth.name
        self.title = ""
        self.description = ""
        self.price = 0
        self.category = ""
        self.subcategory = ""
        self.location = ""
        self.contact = ""
        self.dataCreated = Date()
    }
    
    init(
        productId: String,
        userId: String,
        userFullname: String,
        title: String,
        description: String,
        price: Int,
        category: String,
        subcategory: String,
        location: String,
        contact: String,
        dataCreated: Date? = nil
    ) {
        self.productId = productId
        self.userId = userId
        self.userFullname = userFullname
        self.title = title
        self.description = description
        self.price = price
        self.category = category
        self.subcategory = subcategory
        self.location = location
        self.contact = contact
        self.dataCreated = dataCreated
    }
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case userId = "user_id"
        case userFullname = "user_fullname"
        case title = "title"
        case description = "description"
        case price = "price"
        case category = "category"
        case subcategory = "subcategory"
        case location = "location"
        case contact = "contact"
        case dataCreated = "data_created"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.productId = try container.decode(String.self, forKey: .productId)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.userFullname = try container.decodeIfPresent(String.self, forKey: .userFullname)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode(Int.self, forKey: .price)
        self.category = try container.decode(String.self, forKey: .category)
        self.subcategory = try container.decode(String.self, forKey: .subcategory)
        self.location = try container.decode(String.self, forKey: .location)
        self.contact = try container.decode(String.self, forKey: .contact)
        self.dataCreated = try container.decodeIfPresent(Date.self, forKey: .dataCreated)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.productId, forKey: .productId)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.userFullname, forKey: .userFullname)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.price, forKey: .price)
        try container.encode(self.subcategory, forKey: .subcategory)
        try container.encode(self.location, forKey: .location)
        try container.encode(self.contact, forKey: .contact)
        try container.encode(self.dataCreated, forKey: .dataCreated)
    }
}
