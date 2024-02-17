//
//  ChooseSubcategoryViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 08.02.2024.
//

import SwiftUI

class ChooseSubcategoryViewModel: ObservableObject {
    @Published var savedProductCategory: String?
    @Published var selectedTag: String? = ""
    @Published var isButton: Bool = false
    
    let defaults = UserDefaults.standard
    
    var isTagSelected: Bool {
        return selectedTag != nil
    }
    
    init() {
        getSavedProductFromCategory()
    }
    
    func initiateSavingSubcategory() {
        Task {
            do {
                try? await saveSubcategoryAndNavigate()
            } catch { }
        }
    }
    
    func saveSubcategoryAndNavigate() async throws {
        if let selectedTag = selectedTag {
            UserDefaults.standard.selectedSubcategory = selectedTag
            DispatchQueue.main.async {
                self.isButton = true
            }
        }
    }
    
    func getSavedProductFromCategory() {
        self.savedProductCategory = defaults.selectedProductCategory
    }
}
