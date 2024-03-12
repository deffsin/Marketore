//
//  AccountView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isFullScreenCoverShown: Bool = false
    @Published var isFiltersScreenShown: Bool = false
}

struct AccountView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: AccountViewModel
    @StateObject var appState = AppState()
    
    @State private var scrollOffset: CGFloat = 0
    @State private var isStarFilled: Bool = false
    @State var Height: CGFloat = 150
    @State var heightSecond: CGFloat = 130
        
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
        .fullScreenCover(isPresented: $appState.isFullScreenCoverShown) {
            AccountNavigation.category
                .environmentObject(appState)
        }
        .onChange(of: viewModel.isButton) { state in
            if state {
                appState.isFullScreenCoverShown = true
            }
        }
        .overlay {
            if viewModel.showFilters {
                filters()
                    .transition(.opacity)
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
                    viewModel.initiateNavigationToAddProduct()
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
                Button(action: {
                    withAnimation(.bouncy) {
                        viewModel.showFilters.toggle()
                    }
                }) {
                    Image(systemName: "text.justify")
                        .font(.system(size: 23))
                }
                SquareAnimate(Height: $Height, heightSecond: $heightSecond)
            }
            
            Divider()
                .background(Color(appColor: .whiteColor))
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Height), spacing: 10)], spacing: 10) {
                if let products = viewModel.allProducts {
                    ForEach(products, id: \.title) { item in
                        NavigationLink(destination: AccountNavigation.detail(title: item.title)) {
                            CellView(title: item.title, height: heightSecond)
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
    
    func filters() -> some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeIn) {
                        viewModel.showFilters.toggle()
                    }
                }
            
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Filters")
                    .font(.system(size: 14))
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 15)
            }
            .frame(width: 330, height: 280)
            .background(.white)
            .cornerRadius(15)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    AccountView(viewModel: AccountViewModel())
}
