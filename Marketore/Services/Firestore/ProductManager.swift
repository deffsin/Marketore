//
//  ProductManager.swift
//  Marketore
//
//  Created by Denis Sinitsa on 06.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage


class ProductManager: ObservableObject {
    static let shared = ProductManager()
    private init() {}
        
    func productCollection(userId: String) -> CollectionReference {
        UserManager.shared.userDocument(userId: userId).collection("products")
    }
    
    func productDocument(userId: String, productId: String) -> DocumentReference {
        productCollection(userId: userId).document(productId)
    }
    
    func saveProduct(id: String, fullname: String, title: String, description: String?, price: Int, category: String, subcategory: String, location: String, contact: String, selectedImage: UIImage) async throws {
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            print("No image selected")
            return
        }
        
        let storageRef = Storage.storage().reference()
        let path = "images/products/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        fileRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            guard let self = self else { return }
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }
            
            fileRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                Task {
                    do {
                        let document = self.productCollection(userId: id).document()
                        let documentId = document.documentID
                        
                        var data: [String: Any] = [
                            Product.CodingKeys.productId.rawValue: documentId,
                            Product.CodingKeys.userId.rawValue: id,
                            Product.CodingKeys.userFullname.rawValue: fullname,
                            Product.CodingKeys.title.rawValue: title,
                            Product.CodingKeys.description.rawValue: description,
                            Product.CodingKeys.price.rawValue: price,
                            Product.CodingKeys.category.rawValue: category,
                            Product.CodingKeys.subcategory.rawValue: subcategory,
                            Product.CodingKeys.location.rawValue: location,
                            Product.CodingKeys.contact.rawValue: contact,
                            Product.CodingKeys.dataCreated.rawValue: Date(),
                            Product.CodingKeys.url.rawValue: downloadURL.absoluteString // previosly i was saving a path, but now i need to get a URL for use with kingfisher
                        ]
                        
                        try await document.setData(data, merge: false)
                        
                        DispatchQueue.main.async {
                            print("Product successfully saved with image")
                        }
                    } catch {
                        print("Error saving product data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func getAllProducts(userId: String, priceDescending descending: Bool?) async throws -> [Product] {
        do {
            let snapshot = try await productCollection(userId: userId).getDocuments()
            var products = snapshot.documents.compactMap { try? $0.data(as: Product.self) }
            
            products.sort { (product1: Product, product2: Product) -> Bool in
                if let descending = descending {
                    return descending ? product1.price > product2.price : product1.price < product2.price
                }
                return false
            }
            return products
            
        } catch {
            throw AppError.connectionFailed
        }
    }
    
    func removeProduct(userId: String, productId: String) async throws {
        try await productDocument(userId: userId, productId: productId).delete()
    }
}
