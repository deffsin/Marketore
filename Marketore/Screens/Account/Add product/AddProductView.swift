//
//  AddProductView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.02.2024.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AddProductViewModel
    
    var body: some View {
        NavigationStack {
            buildMainContent()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ScrollView(.vertical) {
            TagLayout(alignment: .center, spacing: 10) {
                ForEach(viewModel.tags, id: \.self) { tag in
                    tagView(tag, viewModel.selectedTag == tag ? Color(appColor: .purpleColor) : .gray)
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
        .padding(.top, 50)
        .overlay {
            customNavBar()
        }
    }
    func customNavBar() -> some View {
        return ZStack {
            Group {
                Color(red: 0.06, green: 0.06, blue: 0.06)
            }
            .ignoresSafeArea(.all)
            
            HStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                            Spacer()
                        }
                    }
                }
                .font(.system(size: 17))
                .foregroundStyle(.white)
                .padding(.horizontal, 1)
                
                Spacer()
            }
            .font(.title)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .frame(height: 35)
        .frame(maxHeight: .infinity, alignment: .top)
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
