//
//  ProductManager.swift
//  Marketore
//
//  Created by Denis Sinitsa on 06.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class ProductManager: ObservableObject {
    static let shared = ProductManager()
    private init() {}
        
    func productCollection(userId: String) -> CollectionReference {
        UserManager.shared.userDocument(userId: userId).collection("products")
    }
    
    func productDocument(userId: String, productId: String) -> DocumentReference {
        productCollection(userId: userId).document(productId)
    }
    
    func saveProduct(id: String, fullname: String, title: String, description: String?, category: String, subcategory: String, location: String, contact: String) async throws {
        Task {
            do {
                let document = productCollection(userId: id).document()
                let documentId = document.documentID
                
                let data: [String:Any] = [
                    Product.CodingKeys.userId.rawValue : id,
                    Product.CodingKeys.userFullname.rawValue : fullname,
                    Product.CodingKeys.title.rawValue : title,
                    Product.CodingKeys.description.rawValue : description,
                    Product.CodingKeys.category.rawValue : category,
                    Product.CodingKeys.subcategory.rawValue : subcategory,
                    Product.CodingKeys.location.rawValue : location,
                    Product.CodingKeys.contact.rawValue : contact
                    
                ]
                try await document.setData(data, merge: false)
            } catch {
                throw UserManagerError.connectionFailed
            }
        }
    }
}
