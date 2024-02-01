//
//  ChooseCategoryViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

class ChooseCategoryViewModel: ObservableObject {
    @Published var selectedTag: ProductCategories?
    
    var isTagSelected: Bool {
        guard let tag = selectedTag?.rawValue.isEmpty else {
            return false
        }
        return true
    }
}
