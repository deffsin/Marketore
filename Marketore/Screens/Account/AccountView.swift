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
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ZStack {
            Color.black.opacity(0.8)
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
                try? await viewModel.loadUserData()
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
        .task {
            try? await viewModel.loadUserData()
        }
        .navigationDestination(isPresented: $viewModel.isAddProduct) {
            AddProductView(viewModel: AddProductViewModel())
        }
    }
    
    func customNavBar(offset: CGFloat) -> some View {
        let maxOffset: CGFloat = 20.0
        let limitedOffset = min(maxOffset, abs(offset)) * (offset < 0 ? -2 : 2)
        
        let isDarkMode = colorScheme == .dark
        let isNegativeOffset = offset < 0
        
        return ZStack {
            Group {
                if isDarkMode {
                    isNegativeOffset ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.06, green: 0.06, blue: 0.06)
                } else {
                    isNegativeOffset ? Color(red: 0.90, green: 0.90, blue: 0.90) : Color.white
                }
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
                    Task {
                        do {
                            try? await viewModel.navigateToAddProduct()
                        } catch {
                            
                        }
                    }
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
        Text("AccountView")
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
