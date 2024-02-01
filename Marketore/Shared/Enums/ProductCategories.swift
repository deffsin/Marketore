//
//  ProductCategories.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

enum ProductCategories: String, CaseIterable, Identifiable { // Used in the AddProductView
    case computers = "Computers 💻"
    case phone = "Phones 📱"
    case tv = "Tv, audio, video, consoles 🖥️"
    case furniture = "Furniture 🛏️"
    case sport = "Sport and fitness ⚽️"
    case beautyAndHealth = "Beaty and health 🧴"
    
    var id: Self { self }
}
