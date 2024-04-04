//
//  BookmarkManager.swift
//  Marketore
//
//  Created by Denis Sinitsa on 03.04.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class BookmarkManager: ObservableObject {
    static let shared = BookmarkManager()
    private init() {}
        
    func bookmarkCollection(userId: String) -> CollectionReference {
        UserManager.shared.userDocument(userId: userId).collection("bookmarks")
    }
    
    func bookmarktDocument(userId: String, productId: String) -> DocumentReference {
        bookmarkCollection(userId: userId).document(productId)
    }
    
    func saveBookmark(productId: String, userId: String, productUserId: String) async throws {
        Task {
            do {
                let document = bookmarkCollection(userId: userId).document()
                //let documentId = document.documentID
                
                let data: [String: Any] = [
                    Bookmark.CodingKeys.productId.rawValue: productId,
                    Bookmark.CodingKeys.userId.rawValue: userId,
                    Bookmark.CodingKeys.productUserId.rawValue : productUserId
                ]
                
                try await document.setData(data, merge: false)
            } catch {
                print("Error saving bookmark data: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllBookmarks(userId: String) async throws -> [Bookmark] {
        do {
            let snapshot = try await bookmarkCollection(userId: userId).getDocuments()
            let bookmarks = snapshot.documents.compactMap {try? $0.data(as: Bookmark.self) }
            
            return bookmarks
        } catch {
            throw AppError.connectionFailed
        }
    }
}
