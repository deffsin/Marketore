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
            ScrollView {
                HStack {
                    Spacer()
                    VStack {
                        if let user = viewModel.user {
                            Text("AccountView")
                            Text("\(user.hasMarketProduct! ? "True" : "False")") // test
                        }
                    }
                    .foregroundStyle(.white)
                    Spacer()
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self, value: $0.frame(in: .global).minY)
                })
                .padding(.horizontal, 15)
            }
            .padding(.top, 50)
            .refreshable {
                // refresh....
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
                
                Button(action: { }) {
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

}

#Preview {
    AccountView(viewModel: AccountViewModel())
}
