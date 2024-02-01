//
//  AddProductView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

struct AddProductView: View {
    @ObservedObject var viewModel: AddProductViewModel
    
    var body: some View {
        NavigationStack {
            buildMainContent()
        }
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ScrollView(.vertical) {
            TagLayout(alignment: .center, spacing: 10) {
                ForEach(viewModel.tags, id: \.self) { tag in
                    tagView(tag, viewModel.selectedTag == tag ? .purple : .gray)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if viewModel.selectedTag == tag {
                                    viewModel.selectedTag = nil
                                } else {
                                    viewModel.selectedTag = tag
                                }
                            }
                         }
                }
            }
        }
    }
    
    func tagView(_ tag: String, _ color: Color) -> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background {
            Capsule()
                .fill(color)
        }
    }
}

#Preview {
    AddProductView(viewModel: AddProductViewModel())
}
