//
//  SubcategoryView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 08.02.2024.
//

import SwiftUI

struct SubcategoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SubcategoryViewModel
    
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
            
            VStack {
                header()
                    .padding([.horizontal, .vertical], 10)
                
                TagLayout(alignment: .center, spacing: 10) {
                    if viewModel.savedProductCategory == "computers" {
                        ForEach(ComputerSubcategory.allCases) { category in
                            tagView(category.rawValue, viewModel.selectedCategory == category.rawValue ? Color(appColor: .purpleColor) : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.selectedCategory = category.rawValue
                                    }
                                    print("\(String(describing: viewModel.selectedCategory))")
                                }
                        }
                    } else if viewModel.savedProductCategory == "phones" {
                        ForEach(PhoneSubcategory.allCases) { tag in
                            tagView(tag.rawValue, viewModel.selectedCategory == tag.rawValue ? Color(appColor: .purpleColor) : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.selectedCategory = tag.rawValue
                                    }
                                    print("\(String(describing: viewModel.selectedCategory))")                                }
                        }
                    }
                }
                
                styledButton()
                    .padding(.top, 70)
                Spacer()
            }
            .padding(.top, 50)
            .overlay {
                customNavBar()
            }
            
            NavigationLink(destination: AccountNavigation.productInfo, isActive: $viewModel.isNavigationEnabled) {}
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
            headerItem()
        }
    }

    func headerItem(isActive: Bool = false) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 35, height: 8)
            .foregroundColor(isActive ? .white : .gray.opacity(0.5))
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
            viewModel.saveCategory()
        }) {
            Text("Next")
                .frame(width: 100, height: 50)
                .foregroundStyle(.white)
                .background(.green)
                .cornerRadius(15)
        }
        .disabled(!viewModel.isCategorySelected)
        .opacity(viewModel.isCategorySelected ? 1 : 0.5)
    }
}

#Preview {
    SubcategoryView(viewModel: SubcategoryViewModel())
}
