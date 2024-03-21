//
//  MarketNavigation.swift
//  Marketore
//
//  Created by Denis Sinitsa on 21.03.2024.
//

import SwiftUI

enum MarketNavigation: Hashable, Identifiable, View {
    var id: Self { self }
    
    case detail(productId: String, title: String, description: String, price: Int, location: String, contact: String)
    
    var body: some View {
        switch self {
        case .detail(let productId, let title, let description, let price, let location, let contact):
            MarketCellDetailView(productId: productId, title: title, description: description, price: price, location: location, contact: contact)
        }
    }
}
