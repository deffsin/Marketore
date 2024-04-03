//
//  MarketNavigation.swift
//  Marketore
//
//  Created by Denis Sinitsa on 21.03.2024.
//

import SwiftUI

enum MarketNavigation: Hashable, Identifiable, View {
    var id: Self { self }
    
    case detail(productId: String, productUserId: String, title: String, description: String, price: Int, location: String, contact: String, imageURL: String)
    
    var body: some View {
        switch self {
        case .detail(let productId, let productUserId, let title, let description, let price, let location, let contact, let url):
            MarketCellDetailView(productId: productId, productUserId: productUserId, title: title, description: description, price: price, location: location, contact: contact, imageURL: url)
        }
    }
}
