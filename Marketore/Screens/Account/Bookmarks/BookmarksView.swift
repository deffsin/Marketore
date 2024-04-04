//
//  BookmarksView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.04.2024.
//

import SwiftUI

struct BookmarksView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: BookmarksViewModel
    
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
                    Spacer()
                    Text("BookmarksView")
                    Spacer()
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
        .foregroundStyle(.white)
        .task {
            viewModel.getUsersData {
                viewModel.getBookmarksData {
                    viewModel.findProductsInBookmarks()
                }
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
                Button(action: {
                    dismiss()
                    
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.down")
                        Text("Close")
                    }
                }
                .font(.system(size: 17))
                
                Spacer()
            }
            .font(.title)
            .foregroundStyle(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
        }
        .frame(height: 35)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    BookmarksView(viewModel: BookmarksViewModel())
}
