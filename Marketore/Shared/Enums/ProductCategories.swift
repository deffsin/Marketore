//
//  ProductCategories.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

enum ProductCategory: String, CaseIterable, Identifiable {
    case computers = "Computers"
    case phones = "Phones"
    
    var id: Self { self }
}

enum ComputerSubcategory: String, CaseIterable, Identifiable {
    case notebooks = "Notebooks"
    case pcComponents = "PC Components"
    
    var id: Self { self }
}

enum PhoneSubcategory: String, CaseIterable, Identifiable {
    case iphone = "iPhone"
    case samsung = "Samsung"
    
    var id: Self { self }
}

extension UserDefaults {
    private enum Keys {
        static let productCategory = "productCategory"
        static let productSubcategory = "productSubcategory"
    }
    
    var selectedProductCategory: ProductCategory? {
        get {
            guard let stringValue = string(forKey: Keys.productCategory) else {
                return nil
            }
            return ProductCategory(rawValue: stringValue)
        } set {
            set(newValue?.rawValue, forKey: Keys.productCategory)
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

// extension for each enum that will return string

//case computers = "Computers 💻"
//case phone = "Phones 📱"
//case tv = "Tv, audio, video, consoles 🖥️"
//case furniture = "Furniture 🛏️"
//case sport = "Sport and fitness ⚽️"
//case beautyAndHealth = "Beaty and health 🧴"
