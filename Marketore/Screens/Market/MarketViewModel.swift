//
//  MarketViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

class MarketViewModel: ObservableObject {
    @Published private(set) var allProducts: [Product]? = nil
    @Published private(set) var users: [UserModel]? = nil
    @Published private(set) var user: UserModel? = nil
    @Published var showFilters: Bool = false
    @Published var selectedFilter: FilterOption? = nil
        
    init() {
        initiateUserDataLoading()
        initiateUsersDataLoading()
    }
    
    /// Initiation
    ///
    func initiateUserDataLoading() {
        Task {
            try? await getUserData()
        }
    }
    
    func initiateUsersDataLoading() {
        Task {
            try? await getUsersData() {
                self.initiateProductLoading()
            }
        }
    }
    
    func initiateProductLoading() {
        Task {
            try? await getProducts()
        }
    }
    ///
    
    /// Data fetching and saving
    ///
    func getUserData() async throws {
        Task {
            do {
                let authDataResult = try AuthenticationManager.shared.authenticatedUser()
                
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
    
    func getUsersData(completion: @escaping () -> Void) async throws {
        Task {
            do {
                let users = try? await UserManager.shared.getAllUsers()
                
                DispatchQueue.main.async {
                    self.users = users
                    completion()
                }
            } catch {
                throw AppError.connectionFailed
            }
        }
    }
    
    func getProducts() async throws {
        Task {
            do {
                guard let userIds = users?.compactMap({ $0.userId }) else { return }
                var combinedProducts = [Product]()
                
                for user in userIds {
                    let products = try await ProductManager.shared.getAllProducts(userId: user, priceDescending: selectedFilter?.priceDescending)
                    combinedProducts.append(contentsOf: products)
                }
                
                DispatchQueue.main.async {
                    self.allProducts = combinedProducts
                }
            } catch {
                AppError.connectionFailed
            }
        }
    }
    ///
    
    func filterSelected(option: FilterOption) async throws {
        DispatchQueue.main.async {
            self.selectedFilter = option
        }
        try? await getProducts()
    }
}
