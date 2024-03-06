//
//  CategoryViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

class CategoryViewModel: ObservableObject, SaveDataUD {
    @Published var selectedTag: ProductCategory?
    @Published var isButton: Bool = false
    
    var isTagSelected: Bool {
        return selectedTag != nil
    }
    
    /// Initiation
    ///
    func initiateSavingCategory() {
        saveDataAndNavigate()
    }
    ///
    
    /// Data fetching and saving below
    ///
    func saveDataAndNavigate() {
        if let selectedTag = selectedTag {
            UserDefaultsHelper.shared.setData(value: selectedTag.rawValue, key: .productCategory)
            DispatchQueue.main.async {
                self.isButton.toggle()
            }
        }
    }
}
