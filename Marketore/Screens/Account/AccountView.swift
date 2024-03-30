//
//  AccountView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isFullScreenCoverShown: Bool = false
}

struct AccountView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel: AccountViewModel
    @StateObject var appState = AppState()
    
    @State private var scrollOffset: CGFloat = 0
        
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
                        ForEach(viewModel.retrievedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
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
        .fullScreenCover(isPresented: $appState.isFullScreenCoverShown) {
            AccountNavigation.category
                .environmentObject(appState)
        }
        .onChange(of: viewModel.isButton) { state in
            if state {
                appState.isFullScreenCoverShown = true
            }
        }
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
                        .padding(9)
                        .background(.clear)
                        .frame(width: 39, height: 48)
                        .offset(x: -limitedOffset * 0.1)
                }
                Spacer()
                
                Text("Account")
                    
                Spacer()
                
                Button(action: {
                    viewModel.navigateToAddProductScreen()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(9)
                        .background(Circle().fill(Color(appColor: .purpleColor)))
                        .frame(width: 39, height: 39)
                        .offset(x: limitedOffset * 0.1)
                }
            }
            .font(.title)
            .foregroundStyle(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 7)
        }
        .frame(height: 35)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func contentIfUserHasMarketProduct() -> some View {
        VStack {
            HStack(spacing: 15) {
                Spacer()
                
                HStack(spacing: 3) {
                    Image(systemName: "arrow.up.arrow.down")
                    
                    Menu("\(viewModel.selectedFilter?.rawValue ?? "No filter")") {
                        ForEach(FilterOption.allCases, id: \.self) { option in
                            Button(option.rawValue) {
                                Task {
                                    try? await viewModel.applyFilterAndReloadProducts(option: option)
                                }
                            }
                        }
                    }
                }
                .font(.system(size: 17))
            }
            
            Divider()
                .background(Color(appColor: .whiteColor))
                .padding(.top, 5)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 10)], spacing: 10) {
                if let products = viewModel.allProducts {
                    ForEach(products, id: \.productId) { item in
                        NavigationLink(destination: AccountNavigation.detail(productId: item.productId, title: item.title, description: item.description, price: item.price, location: item.location, contact: item.contact, imageURL: item.url)) {
                            CellView(title: item.title, imageURL: item.url)
                        }
                    }
                    .shadow(radius: 10)
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
