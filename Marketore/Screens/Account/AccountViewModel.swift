//
//  AccountViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI
import FirebaseStorage

class AccountViewModel: ObservableObject {
    @Published private(set) var allProducts: [Product]? = nil
    @Published private(set) var user: UserModel? = nil
    @Published var isButton: Bool = false
    @Published var showFilters: Bool = false
    @Published var selectedFilter: FilterOption? = nil
    @Published var retrievedImages = [UIImage]()
    
    var authUserId: String?
    
    init() {
        loadUserData()
        loadProductsData()
    }
    
    /// Initiation
    ///
    func navigateToAddProductScreen() {
        Task {
            await navigateToAddProduct()
        }
    }
    
    func loadUserData() {
        Task {
            try? await getUserData()
        }
    }
    
    func loadProductsData() {
        Task {
            try? await getProducts()
        }
    }
    ///
    
    /// Data fetching and saving below
    ///
    func getUserData() async throws {
        Task {
            do {
                let authDataResult = try AuthenticationManager.shared.authenticatedUser()
                self.authUserId = authDataResult.uid
                
                guard let user = try? await UserManager.shared.getUser(userId: authDataResult.uid) else {
                    throw AppError.unauthorized
                }
                
                DispatchQueue.main.async {
                    self.user = user
                }
            } catch {
                throw AppError.unknownError
            }
        }
    }
    
    func getProducts() async throws {
        Task {
            do {
                let authDataResult = try AuthenticationManager.shared.authenticatedUser()
                let allProducts = try await ProductManager.shared.getAllProducts(userId: authDataResult.uid, priceDescending: selectedFilter?.priceDescending)
                DispatchQueue.main.async {
                    self.allProducts = allProducts
                }
            } catch {
                throw AppError.unknownError
            }
        }
    }
    ///
    
    func navigateToAddProduct() async {
        DispatchQueue.main.async {
            self.isButton.toggle()
        }
    }
    
    func applyFilterAndReloadProducts(option: FilterOption) async throws {
        DispatchQueue.main.async {
            self.selectedFilter = option
        }
        try? await getProducts()
    }
}
