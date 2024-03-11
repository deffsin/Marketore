//
//  CellDetailView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.03.2024.
//

import SwiftUI

struct CellDetailView: View {
    @State var title: String?
    
    var body: some View {
        Text(title ?? "None")
    }
}

#Preview {
    CellDetailView()
}
