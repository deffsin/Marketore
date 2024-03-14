//
//  FilterOption.swift
//  Marketore
//
//  Created by Denis Sinitsa on 14.03.2024.
//

import SwiftUI

enum FilterOption: String, CaseIterable {
    case noFilter = "No filter"
    case priceHigh = "Price high to low"
    case priceLow = "Price low to high"
    
    var priceDescending: Bool? {
        switch self {
        case .noFilter: return nil
        case .priceHigh: return true
        case .priceLow: return false
        }
    }
}
