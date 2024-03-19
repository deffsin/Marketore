//
//  MarketView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

struct MarketView: View {
    @ObservedObject var viewModel: MarketViewModel
    
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            buildMainContent()
        }
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ZStack {
            Color(appColor: .darkBackgroundColor)
                .ignoresSafeArea(.all)
            
            ScrollView {
                HStack {
                    //Spacer()
                    if let products = viewModel.allProducts {
                        ForEach(products, id: \.productId) { product in
                            Text(product.title)
                                .foregroundStyle(.white)
                        }
                    }
                    //Spacer()
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self, value: $0.frame(in: .global).minY)
                })
                .padding(.horizontal, 15)
            }
            .padding(.top, 50)
            .onPreferenceChange(ViewOffsetKey.self) { offset in
                withAnimation {
                    self.scrollOffset = offset
                }
            }
            .overlay {
                customNavBar(offset: scrollOffset)
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
                Spacer()
                Text("Market")
                Spacer()
            }
            .font(.title)
            .foregroundStyle(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 7)
        }
        .frame(height: 35)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func productsView() -> some View {
        VStack {
            HStack(spacing: 15) {
                Spacer()
                
                HStack(spacing: 3) {
                    Image(systemName: "arrow.up.arrow.down")
                    
                    Menu("\(viewModel.selectedFilter?.rawValue ?? "No filter")") {
                        ForEach(FilterOption.allCases, id: \.self) { option in
                            Button(option.rawValue) {
                                Task {
                                    // try? await viewModel.filterSelected(option: option)
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
                    ForEach(products, id: \.productId) { item in // id: \.id, not title
                        NavigationLink(destination: AccountNavigation.detail(productId: item.productId, title: item.title, description: item.description, price: item.price, location: item.location, contact: item.contact)) {
                            CellView(title: item.title)
                        }
                    }
                    .shadow(radius: 10)
                }
            }
        }
    }
}

#Preview {
    MarketView(viewModel: MarketViewModel())
}
