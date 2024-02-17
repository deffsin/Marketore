//
//  ChooseCategoryViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

class ChooseCategoryViewModel: ObservableObject {
    @Published var selectedTag: ProductCategory?
    @Published var isButton: Bool = false
    
    let defaults = UserDefaults.standard
    
    var isTagSelected: Bool {
        return selectedTag != nil
    }
    
    func initiateSavingCategory() {
        Task {
            do {
                try? await saveCategoryAndNavigate()
            } catch { }
        }
    }
    
    func saveCategoryAndNavigate() {
        if let selectedTag = selectedTag {
            defaults.selectedProductCategory = selectedTag.rawValue
            DispatchQueue.main.async {
                self.isButton = true
            }
        }
    }
}
