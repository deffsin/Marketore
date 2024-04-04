//
//  BookmarksViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.04.2024.
//

import SwiftUI

/// the reason why i'm using here completion handlers - async/await code is not working properly here
class BookmarksViewModel: ObservableObject {
    @Published private(set) var users: [UserModel]? = nil
    @Published private(set) var bookmarks: [Bookmark]? = nil
    
    func getUsersData(completion: @escaping () -> Void) {
        Task {
            let users = try? await UserManager.shared.getAllUsers()
            
            DispatchQueue.main.async {
                self.users = users
                completion()
            }
        }
    }
    
    func getBookmarksData(completion: @escaping () -> Void) {
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            let bookmarks = try await BookmarkManager.shared.getAllBookmarks(userId: authDataResult.uid)
            
            DispatchQueue.main.async {
                self.bookmarks = bookmarks
                completion()
            }
        }
    }
    
    func findProductsInBookmarks() {
        Task {
            guard let bookmarks = self.bookmarks, let users = self.users else {
                return
            }
            
            for bookmark in bookmarks {
                if let user = users.first(where: { $0.userId == bookmark.userId }) {
                    let products = try await ProductManager.shared.getAllProducts(userId: bookmark.productUserId, priceDescending: false)
                    if products.contains(where: { $0.productId == bookmark.productId }) {
                        print("Product with ID \(bookmark.productId) found for user with ID \(bookmark.productUserId)")
                    }
                }
            }

        }
    }
}
