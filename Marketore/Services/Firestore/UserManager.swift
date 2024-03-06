import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserManager {
    static let shared = UserManager()
    private init() {}
    
    let userCollection: CollectionReference = Firestore.firestore().collection("users")
        
    func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func getUser(userId: String) async throws -> UserModel {
        do {
            let user = try await userDocument(userId: userId).getDocument(as: UserModel.self)
            return user
            
        } catch {
            throw AppError.connectionFailed
        }
    }
    
    func createNewUser(user: UserModel) async throws {
        do {
            try userDocument(userId: user.userId).setData(from: user, merge: false)
        } catch {
            throw AppError.connectionFailed
        }
    }
}
