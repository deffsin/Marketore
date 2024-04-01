//
//  AccountNavigation.swift
//  Marketore
//
//  Created by Denis Sinitsa on 02.03.2024.
//

import SwiftUI

enum AccountNavigation: Hashable, Identifiable, View {
    var id: Self { self }
    
    case account
    case category
    case subcategory
    case productInfo
    case detail(productId: String, title: String, description: String, price: Int, location: String, contact: String, imageURL: String)
    case bookmarks
    
    var body: some View {
        switch self {
        case .account:
            AccountView(viewModel: AccountViewModel())
        case .category:
            CategoryView(viewModel: CategoryViewModel())
        case .subcategory:
            SubcategoryView(viewModel: SubcategoryViewModel())
        case .productInfo:
            ProductInfoView(viewModel: ProductInfoViewModel(), isShowing: .constant(false))
        case .detail(let productId, let title, let description, let price, let location, let contact, let url):
            AccountCellDetailView(productId: productId, title: title, description: description, price: price, location: location, contact: contact, imageURL: url)
        case .bookmarks:
            BookmarksView(viewModel: BookmarksViewModel())
        }
    }
}
