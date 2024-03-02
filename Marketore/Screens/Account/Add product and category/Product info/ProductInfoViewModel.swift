//
//  ProductInfoViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.02.2024.
//

import Foundation

class ProductInfoViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var location: String = ""
    @Published var contact: String = ""
    var savedProduct: String?
    var savedSubproduct: String?
    
    var allData = [String]()
    
    init() {
        getData()
    }
    
    func getData() {
        self.savedProduct = UserDefaultsHelper.shared.getData(type: String.self, forKey: .productCategory)
        self.savedSubproduct = UserDefaultsHelper.shared.getData(type: String.self, forKey: .productSubcategory)
        saveDataToArray()
    }
    
    func saveDataToArray() {
        if let product = savedProduct {
            allData.append(product)
        }
        
        if let subproduct = savedSubproduct {
            allData.append(subproduct)
        }
    }
}
