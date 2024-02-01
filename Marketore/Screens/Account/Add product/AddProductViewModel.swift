//
//  AddProductViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

class AddProductViewModel: ObservableObject {
    @Published var tags: [String] = ["Swift", "C#", "Ruby", "Kotlin", "Python", "Lua", "C++", "Objective-C"]
    @Published var selectedTag: String? = nil
}
