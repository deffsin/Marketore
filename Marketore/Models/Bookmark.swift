//
//  Bookmark.swift
//  Marketore
//
//  Created by Denis Sinitsa on 03.04.2024.
//

import SwiftUI

struct Bookmark: Codable {
    let productId: String
    let userId: String
    let productUserId: String
    
    init(auth: AuthDataResultModel) {
        self.productId = ""
        self.userId = ""
        self.productUserId = ""
    }
    
    init(
        productId: String,
        userId: String,
        productUserId: String
    ) {
        self.productId = productId
        self.userId = userId
        self.productUserId = productUserId
    }
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case userId = "user_id"
        case productUserId = "product_user_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.productId = try container.decode(String.self, forKey: .productId)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.productUserId = try container.decode(String.self, forKey: .productUserId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.productId, forKey: .productId)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.productUserId, forKey: .productUserId)
    }
}
