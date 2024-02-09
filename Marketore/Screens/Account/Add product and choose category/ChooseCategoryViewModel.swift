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
    
    var isTagSelected: Bool {
        return selectedTag != nil
    }
    
    func saveCategoryAndNavigate() {
        if let selectedTag = selectedTag {
            UserDefaults.standard.selectedProductCategory = selectedTag
            DispatchQueue.main.async {
                self.isButton = true
            }
        }
    }
}
