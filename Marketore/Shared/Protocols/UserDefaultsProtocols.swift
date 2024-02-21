//
//  UserDefaults.swift
//  Marketore
//
//  Created by Denis Sinitsa on 21.02.2024.
//

import SwiftUI

protocol SaveDataUD {
    func saveDataAndNavigate() async throws
}

protocol GetDataUD {
    func getData()
}
