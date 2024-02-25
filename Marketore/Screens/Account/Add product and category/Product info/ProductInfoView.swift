//
//  ProductInfoView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.02.2024.
//

import SwiftUI

struct ProductInfoView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProductInfoViewModel
    
    var body: some View {
        ZStack {
            buildMainContent()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ZStack {
            Color(appColor: .darkBackgroundColor)
                .ignoresSafeArea(.all)
            
            HStack {
                Spacer()
                VStack {
                    header()
                        .padding([.horizontal, .vertical], 10)
                    
                    /// Photo....
                    
                    textFields()
                    
                    styledButton()
                        .padding(.top, 70)
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 50)
            .overlay {
                customNavBar()
            }
        }
    }
    
    func customNavBar() -> some View {
        return ZStack {
            Group {
                Color(appColor: .darkGrayColor)
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
    
    func header() -> some View {
        HStack {
            headerItem(isActive: true)
            headerItem(isActive: true)
            headerItem(isActive: true)
        }
    }

    func headerItem(isActive: Bool = false) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 35, height: 8)
            .foregroundColor(isActive ? .white : .gray.opacity(0.5))
    }
    
    func textFields() -> some View {
        VStack(spacing: 15) {
            InputField(text: $viewModel.title, title: "Title:", keyboardType: .alphabet)
            textEditor()
            InputField(text: $viewModel.location, title: "Location:", keyboardType: .alphabet)
        }
    }
    
    func textEditor() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 2) {
                Text("Description:")
                Text("(optional)")
                    .font(.system(size: 10))
                    .opacity(0.5)
            }
            .foregroundStyle(.white)
            
            TextEditor(text: $viewModel.description)
                .scrollContentBackground(.hidden)
                .foregroundStyle(.black)
                .background(.white)
                .frame(width: 270, height: 70)
                .cornerRadius(8)
        }
        .font(.system(size: 14))
    }
    
    func styledButton() -> some View {
        Button(action: {

        }) {
            Text("Add")
                .frame(width: 100, height: 50)
                .foregroundStyle(.white)
                .background(.green)
                .cornerRadius(15)
        }
    }
}

#Preview {
    ProductInfoView(viewModel: ProductInfoViewModel())
}
