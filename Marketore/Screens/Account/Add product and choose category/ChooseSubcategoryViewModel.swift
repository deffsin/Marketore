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
    
    var isTagSelected: Bool {
        return selectedTag != nil
    }
    
    init() {
        self.savedProductCategory = UserDefaults.standard.selectedProductCategory
    }
    
    func saveSubcategoryAndNavigate() async throws {
        if let selectedTag = selectedTag {
            UserDefaults.standard.selectedSubcategory = selectedTag
            DispatchQueue.main.async {
                self.isButton = true
            }
        }
    }
}
