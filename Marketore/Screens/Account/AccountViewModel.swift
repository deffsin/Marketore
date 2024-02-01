//
//  AccountViewModel.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

class AccountViewModel: ObservableObject {
    @Published private(set) var user: UserModel? = nil
    @Published var isSheet: Bool = false
    
    func addProductAndOpenSheet() async throws {
        DispatchQueue.main.async {
            self.isSheet = true
            print("Sheet is opened")
        }
    }
    
    func loadUserData() async throws {
        Task {
            do {
                let authDataResult = try AuthenticationManager.shared.authenticatedUser()
                
                guard let user = try? await UserManager.shared.getUser(userId: authDataResult.uid) else {
                    throw UserManagerError.unknownError
                }
                
                DispatchQueue.main.async {
                    self.user = user
                }
            }
        }
    }
}
