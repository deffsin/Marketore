//
//  AccountNavigation.swift
//  Marketore
//
//  Created by Denis Sinitsa on 02.03.2024.
//

import SwiftUI

enum AccountNavigation: String, Hashable, Identifiable, View {
    case account
    case category
    case subcategory
    case productInfo
    
    var id: String {
        self.rawValue
    }
    
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
        }
    }
}
