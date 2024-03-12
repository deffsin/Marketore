//
//  CellView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.03.2024.
//

import SwiftUI

struct CellView: View {
    @State var title: String?
    @State var height: CGFloat?
    
    var body: some View {
        VStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(.blue)
                .frame(height: height)
            
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
