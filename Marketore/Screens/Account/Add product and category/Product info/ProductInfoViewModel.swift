//
//  ProductInfoViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.02.2024.
//

import Foundation

class ProductInfoViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var location: String = ""
    @Published var contact: String = ""
    
    var isMessageToUser: Bool = false
    var messageToUser: String?
    var savedCategory: String?
    var savedSubcategory: String?
    var allData = [String]()
    var dataIsValid: Bool {
        if !(title.isEmpty && location.isEmpty && contact.isEmpty) {
            return true
        }
        return false
    }
    
    init() {
        getData()
    }
    
    func initiateSavingData() async {
        Task {
            if dataIsValid {
                try? await addProductData()
            } else {
                isMessageToUser = true
                messageToUser = "Please, add the title, location and contact information."
            }
        }
    }
    
    func addProductData() async throws {
        Task {
            do {
                let authUser = try AuthenticationManager.shared.authenticatedUser()
                
                try? await UserManager.shared.saveProduct(id: authUser.uid, fullname: authUser.name ?? "", title: title, description: description, category: savedCategory!, subcategory: savedSubcategory!, location: location, contact: contact)
                clearUserDefaults()
            } catch {
                UserManagerError.connectionFailed
            }
        }
    }
    
    func getData() {
        self.savedCategory = UserDefaultsHelper.shared.getData(type: String.self, forKey: .productCategory)
        self.savedSubcategory = UserDefaultsHelper.shared.getData(type: String.self, forKey: .productSubcategory)
        saveDataToArray()
    }
    
    func clearUserDefaults() {
        UserDefaultsHelper.shared.removeData(key: .productCategory)
        UserDefaultsHelper.shared.removeData(key: .productSubcategory)
        print("Removed data from UserDefaults: productCategory and productSubcategory")
    }
    
    func saveDataToArray() {
        if let category = savedCategory {
            allData.append(category)
        }
        
        if let subcategory = savedSubcategory {
            allData.append(subcategory)
        }
    }
}
