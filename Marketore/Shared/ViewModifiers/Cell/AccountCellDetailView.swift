//
//  AccountCellDetailView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.03.2024.
//

import SwiftUI

struct AccountCellDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var productId: String?
    @State var title: String?
    @State var description: String?
    @State var price: Int?
    @State var location: String?
    @State var contact: String?
    @State var removeMarketplaceItemAlert: Bool = false
    
    var body: some View {
        ZStack {
            buildMainContent()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ZStack {
            Color(appColor: .darkBackgroundColor)
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 8) {
                    imageView()
                    
                    titleView()
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(.white)
                    
                    additionalInfoView()
                    
                    Spacer()
                }
            }
        }
        .foregroundStyle(.white)
    }
    
    func imageView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(.blue)
                .frame(width: .infinity)
                .frame(height: 350)
        }
        .overlay {
            buttonsOnTheImage()
                .offset(y: -140)
        }
    }
    
    func titleView() -> some View {
        Text(title ?? "Title")
            .bold()
            .font(.system(size: 25))
        
    }
    
    func additionalInfoView() -> some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    // image?
                    Text("Description:")
                        .bold()
                        .font(.system(size: 19))
                    
                    Text(description ?? "Description....")
                }
                Spacer()
            }
            
            Divider()
                .background(.white)
            
            HStack(spacing: 12) {
                HStack(spacing: 5) {
                    Text("Price:")
                        .bold()
                        .font(.system(size: 19))
                    
                    Text("\(price ?? 0)")
                }
                
                Spacer()
                
                HStack(spacing: 5) {
                    Text("Location:")
                        .bold()
                        .font(.system(size: 19))
                    
                    Text(location ?? "Location")
                }
            }
            .font(.system(size: 16))
            
            Divider()
                .background(.white)
            
            HStack(spacing: 5) {
                Text("Contact:")
                    .bold()
                    .font(.system(size: 19))
                
                Text(contact ?? "+372 12345678")
                
                Spacer()
            }
            .font(.system(size: 16))
        }
        .padding(.horizontal, 15)
    }
    
    func backButtonView() -> some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "arrow.left")
                .font(.system(size: 18))
                .foregroundStyle(.black)
                .padding(7)
                .background(Color(appColor: .whiteColor))
                .clipShape(Circle())
                .opacity(0.9)
        }
    }
    
    func deleteButtonView() -> some View {
        Button(action: {
            removeMarketplaceItemAlert = true
        }) {
            Image(systemName: "trash")
                .font(.system(size: 18))
                .foregroundStyle(.black)
                .padding(7)
                .background(Color(appColor: .whiteColor))
                .clipShape(Circle())
                .opacity(0.9)
        }
        .alert("Deletion notification", isPresented: $removeMarketplaceItemAlert) {
            Button("Remove", role: .destructive) {
                removeItemFromMarketplace(productId: productId!) {
                    dismiss()
                }
            }
        } message: {
            Text("Are you sure you want to remove item from the marketplace?")
        }
    }
    
    func buttonsOnTheImage() -> some View {
        HStack {
            backButtonView()
            
            Spacer()
            
            deleteButtonView()
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    AccountCellDetailView()
}

extension AccountCellDetailView {
    func removeItemFromMarketplace(productId: String, completion: @escaping () -> Void) {
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            try? await ProductManager.shared.removeProduct(userId: authDataResult.uid, productId: productId)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
