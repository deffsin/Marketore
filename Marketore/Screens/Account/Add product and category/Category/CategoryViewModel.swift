//
//  CategoryViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

class CategoryViewModel: ObservableObject, SaveDataUD {
    @Published var selectedCategory: ProductCategory?
    @Published var isNavigationEnabled: Bool = false
    
    var isCategorySelected: Bool {
        return selectedCategory != nil
    }
    
    /// Initiation
    ///
    func initiateSavingCategory() {
        Task {
            try? await saveDataAndNavigate()
        }
    }
    ///
    
    /// Data fetching and saving
    ///
    func saveDataAndNavigate() async throws  {
        if let selectedCategory = selectedCategory {
            UserDefaultsHelper.shared.setData(value: selectedCategory.rawValue, key: .productCategory)
            DispatchQueue.main.async {
                self.isNavigationEnabled.toggle()
            }
        }
    }
}
