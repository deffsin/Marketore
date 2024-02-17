//
//  ChooseSubcategoryView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 08.02.2024.
//

import SwiftUI

struct ChooseSubcategoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ChooseSubcategoryViewModel
    
    var body: some View {
        NavigationStack {
            buildMainContent()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ZStack {
            Color(appColor: .darkBackgroundColor)
                .ignoresSafeArea(.all)
            
            ScrollView(.vertical) {
                TagLayout(alignment: .center, spacing: 10) {
                    if viewModel.savedProductCategory == "computers" {
                        ForEach(ComputerSubcategory.allCases) { tag in
                            tagView(tag.rawValue, viewModel.selectedTag == tag.rawValue ? Color(appColor: .purpleColor) : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.selectedTag = tag.rawValue
                                    }
                                }
                        }
                    } else if viewModel.savedProductCategory == "phones" {
                        ForEach(PhoneSubcategory.allCases) { tag in
                            tagView(tag.rawValue, viewModel.selectedTag == tag.rawValue ? Color(appColor: .purpleColor) : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.selectedTag = tag.rawValue
                                    }
                                }
                        }
                    }
                }
                
                styledButton()
                    .padding(.top, 70)
            }
            .padding(.top, 50)
            .overlay {
                customNavBar()
            }
        }
        .onDisappear {
            if let saved = UserDefaults.standard.selectedSubcategory {
                print(saved)
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
    
    func styledButton() -> some View {
        Button(action: {
            viewModel.initiateSavingSubcategory()
        }) {
            Text("Next")
                .frame(width: 100, height: 50)
                .foregroundStyle(.white)
                .background(.green)
                .cornerRadius(15)
        }
        .disabled(!viewModel.isTagSelected)
        .opacity(viewModel.isTagSelected ? 1 : 0.5)
    }
}

#Preview {
    ChooseSubcategoryView(viewModel: ChooseSubcategoryViewModel())
}
