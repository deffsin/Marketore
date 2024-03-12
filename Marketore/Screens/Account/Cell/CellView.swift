//
//  CellView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.03.2024.
//

import SwiftUI

struct CellView: View {
    @State var title: String?
    
    var body: some View {
        VStack(spacing: 5) {
            Rectangle()
                .fill(.blue)
                .frame(width: 160, height: 160, alignment: .center)
                .cornerRadius(6)
            
            Text(title ?? "Title")
                .font(.system(size: 15))
                .bold()
                .lineLimit(1)
                .truncationMode(.tail)
        }
    }
}

#Preview {
    CellView()
}
