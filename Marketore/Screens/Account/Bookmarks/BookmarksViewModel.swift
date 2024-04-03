//
//  BookmarksViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 01.04.2024.
//

import SwiftUI

class BookmarksViewModel: ObservableObject {
    
    func checkBookmarkExists() {
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            
            try? await BookmarkManager.shared.getAllBookmarks(userId: authDataResult.uid)
        }
    }
}
