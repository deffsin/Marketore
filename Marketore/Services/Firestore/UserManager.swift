import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserManager {
    static let shared = UserManager()
    private init() {}
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
        
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func productCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("products")
    }
    
    func productDocument(userId: String, productId: String) -> DocumentReference {
        productCollection(userId: userId).document(productId) // productId ?????????????????
    }
    
    func getUser(userId: String) async throws -> UserModel {
        do {
            let user = try await userDocument(userId: userId).getDocument(as: UserModel.self)
            return user
            
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
    
    func createNewUser(user: UserModel) async throws {
        do {
            try userDocument(userId: user.userId).setData(from: user, merge: false)
        } catch {
            throw UserManagerError.connectionFailed
        }
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
