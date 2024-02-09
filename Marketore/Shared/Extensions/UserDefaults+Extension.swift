//
//  UserDefaults+Extension.swift
//  Marketore
//
//  Created by Denis Sinitsa on 09.02.2024.
//

import SwiftUI

extension UserDefaults {
    private enum Keys {
        static let productCategory = "productCategory"
        static let productSubcategory = "productSubcategory"
    }
    
    var selectedProductCategory: String? {
        get {
            string(forKey: Keys.productCategory)
        } set {
            set(newValue, forKey: Keys.productCategory)
        }

    }
    
    var selectedSubcategory: String? {
        get {
            string(forKey: Keys.productSubcategory)
        } set {
            set(newValue, forKey: Keys.productSubcategory)
        }
    }
}
