//
//  ProductCategories.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

enum ProductCategory: String, CaseIterable, Identifiable {
    case computers = "computers"
    case phones = "phones"
    
    var id: Self { self }
}

enum ComputerSubcategory: String, CaseIterable, Identifiable {
    case notebooks = "notebooks"
    case components = "components"
    
    var id: Self { self }
}

enum PhoneSubcategory: String, CaseIterable, Identifiable {
    case iphone = "iPhone"
    case samsung = "samsung"
    
    var id: Self { self }
}
