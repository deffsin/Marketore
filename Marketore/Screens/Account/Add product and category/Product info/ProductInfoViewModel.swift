//
//  ProductInfoViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.02.2024.
//

import Foundation
import FirebaseStorage
import UIKit

class ProductInfoViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var price: Int = 0
    @Published var location: String = ""
    @Published var contact: String = ""
    @Published var messageToUser: String?
    @Published var savedCategory: String?
    @Published var savedSubcategory: String?
    @Published var isShowingSnackBar: Bool = false
    @Published var isButton: Bool = false
    @Published var priceString: String = ""
    
    @Published var isPickerShowing = false
    @Published var selectedImage: UIImage?
    
    var snackBarTimer: DispatchWorkItem?
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
    
    /// Initiation
    ///
    func initiateSavingData() async {
        Task {
            if dataIsValid {
                try? await addProductData()
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.isShowingSnackBar = true
                    self?.messageToUser = "Please, add the title, location and contact information ❌"
                }
            }
        }
    }
    ///
    
    /// Data fetching and saving below
    ///
    func addProductData() async throws {
        Task {
            do {
                let authUser = try AuthenticationManager.shared.authenticatedUser()
                
                try? await ProductManager.shared.saveProduct(id: authUser.uid, fullname: authUser.name ?? "", title: title, description: description, price: price, category: savedCategory!, subcategory: savedSubcategory!, location: location, contact: contact)
                updateUserProductStatus()
                clearUserDefaults()
                DispatchQueue.main.async { [weak self] in
                    self?.isShowingSnackBar = true
                    self?.messageToUser = "A product was successfully added 🎉"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                    self?.isButton = true
                }
            } catch {
                throw AppError.connectionFailed
            }
        }
    }
    
    func getData() {
        self.savedCategory = UserDefaultsHelper.shared.getData(type: String.self, forKey: .productCategory)
        self.savedSubcategory = UserDefaultsHelper.shared.getData(type: String.self, forKey: .productSubcategory)
        saveDataToArray()
    }
    
    func saveDataToArray() {
        if let category = savedCategory {
            allData.append(category)
        }
        
        if let subcategory = savedSubcategory {
            allData.append(subcategory)
        }
    }
    ///
    
    func clearUserDefaults() {
        UserDefaultsHelper.shared.removeData(key: .productCategory)
        UserDefaultsHelper.shared.removeData(key: .productSubcategory)
        print("Removed data from UserDefaults: productCategory and productSubcategory")
    }
    
    func showSnackBar() {
        DispatchQueue.main.async { [weak self] in
            self?.isShowingSnackBar = false
        }
    }
    
    func startSnackBarTimer() {
        snackBarTimer?.cancel()
        
        let item = DispatchWorkItem { [weak self] in
            self?.showSnackBar()
        }
        
        snackBarTimer = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: item)
    }
    
    func convertPrice(priceString: String) {
        self.price = Int(priceString) ?? 0
    }
    
    func updateUserProductStatus() {
        Task {
            do {
                let authUser = try AuthenticationManager.shared.authenticatedUser()
                try? await UserManager.shared.updateUserProductStatus(userId: authUser.uid, value: true)
                
            } catch {
                throw AppError.unknownError
            }
        }
    }
    
    func uploadPhoto() {
        guard selectedImage != nil else {
            return
        }
    
        let storageRef = Storage.storage().reference()
    
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
    
        guard imageData != nil else {
            return
        }
    
        let fileRef = storageRef.child("images/products/\(UUID().uuidString).jpg")
    
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
    
            }
        }
    }
}
