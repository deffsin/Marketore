//
//  SubcategoryViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 08.02.2024.
//

import SwiftUI

class SubcategoryViewModel: ObservableObject, SaveDataUD, GetDataUD {
    @Published var savedProductCategory: String?
    @Published var selectedCategory: String?
    @Published var isNavigationEnabled: Bool = false
    
    var isCategorySelected: Bool {
        return selectedCategory != nil
    }
    
    init() {
        getData()
    }
    
    /// Initiation
    ///
    func saveCategory() {
        Task {
            try? await saveDataAndNavigate()
        }
    }
    ///
    
    /// Data fetching and saving below
    ///
    func saveDataAndNavigate() async throws {
        if let selectedCategory = selectedCategory {
            UserDefaultsHelper.shared.setData(value: selectedCategory, key: .productSubcategory)
            DispatchQueue.main.async {
                self.isNavigationEnabled.toggle()
            }
        }
    }
    
    func getData() {
        self.savedProductCategory = UserDefaultsHelper.shared.getData(type: String.self, forKey: .productCategory)
    }
}
