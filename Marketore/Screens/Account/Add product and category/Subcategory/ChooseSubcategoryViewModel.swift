//
//  ChooseSubcategoryViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 08.02.2024.
//

import SwiftUI

class ChooseSubcategoryViewModel: ObservableObject, SaveDataUD, GetDataUD {
    @Published var savedProductCategory: String?
    @Published var selectedTag: String? = ""
    @Published var isButton: Bool = false
        
    var isTagSelected: Bool {
        return selectedTag != nil
    }
    
    init() {
        getData()
    }
    
    func initiateSavingSubcategory() {
        Task {
            do {
                try? await saveDataAndNavigate()
            } catch { }
        }
    }
    
    func saveDataAndNavigate() async throws {
        if let selectedTag = selectedTag {
            UserDefaultsHelper.shared.setData(value: selectedTag, key: .productSubcategory)
            DispatchQueue.main.async {
                self.isButton.toggle()
            }
        }
    }
    
    func getData() {
        self.savedProductCategory = UserDefaultsHelper.shared.getData(type: String.self, forKey: .productCategory)
    }
}
