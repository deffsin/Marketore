//
//  AccountView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: AccountViewModel
    
    @State private var scrollOffset: CGFloat = 0
    @State private var isStarFilled: Bool = false
    
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
            
            ScrollView {
                HStack {
                    Spacer()
                    VStack {
                        if let user = viewModel.user {
                            if user.hasMarketProduct! {
                                contentIfUserHasMarketProduct()
                            } else {
                                contentIfUserDoesntHaveMarketProduct()
                            }
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                    Spacer()
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self, value: $0.frame(in: .global).minY)
                })
                .padding(.horizontal, 15)
            }
            .padding(.top, 50)
            .refreshable {
                try? await viewModel.getUserData()
                try? await viewModel.getProducts()
            }
            .onPreferenceChange(ViewOffsetKey.self) { offset in
                withAnimation {
                    self.scrollOffset = offset
                }
            }
            .overlay {
                customNavBar(offset: scrollOffset)
            }
        }
        
        NavigationLink(destination: AccountNavigation.category, isActive: $viewModel.isButton) {}
    }
    
    func customNavBar(offset: CGFloat) -> some View {
        let maxOffset: CGFloat = 20.0
        let limitedOffset = min(maxOffset, abs(offset)) * (offset < 0 ? -2 : 2)
        
        let isNegativeOffset = offset < 0
        
        return ZStack {
            Group {
                isNegativeOffset ? Color(appColor: .lightGrayColor) : Color(appColor: .darkGrayColor)
            }
            .ignoresSafeArea(.all)
            
            HStack {
                Button(action: { }) {
                    Image(systemName: "bookmark")
                        .resizable()
                        .foregroundColor(.white)
                        .padding(9)
                        .background(.clear)
                        .frame(width: 39, height: 48)
                        .offset(x: -limitedOffset * 0.1)
                }
                Spacer()
                
                Text("Account")
                    
                Spacer()
                
                Button(action: {
                    viewModel.initiateNavigationToAddProduct()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(.white)
                        .padding(9)
                        .background(Circle().fill(Color(appColor: .purpleColor)))
                        .frame(width: 39, height: 39)
                        .offset(x: limitedOffset * 0.1)
                }
            }
            .font(.title)
            .padding(.horizontal, 15)
            .padding(.vertical, 7)
        }
        .frame(height: 35)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func contentIfUserHasMarketProduct() -> some View {
        ZStack {
            if let products = viewModel.allProducts {
                ForEach(products, id: \.title) { product in
                    Text(product.title)
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    func contentIfUserDoesntHaveMarketProduct() -> some View {
        VStack(alignment: .center) {
            Text("Let's add your product to the market")
                .font(.system(size: 21))
            Text("Click on the button '+' in the upper right corner")
                .font(.system(size: 14))
                .opacity(0.8)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    AccountView(viewModel: AccountViewModel())
}
