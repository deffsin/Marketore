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
}
