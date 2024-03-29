//
//  MarketCellDetailView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 21.03.2024.
//

import SwiftUI
import FirebaseStorage

struct MarketCellDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var productId: String?
    @State var title: String?
    @State var description: String?
    @State var price: Int?
    @State var location: String?
    @State var contact: String?
    
    @State var imageURL: String?
    @State var retrievedImage = UIImage()
    
    @State var removeMarketplaceItemAlert: Bool = false
    @State var isLoading = true
    
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
                    backButtonView()
                    
                    if isLoading {
                        ProgressView()
                            .frame(width: 220, height: 220)
                            .tint(.white)
                    } else {
                        imageView()
                        
                        titleView()
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(.white)
                        
                        additionalInfoView()
                    }
                    
                    Spacer()
                }
            }
        }
        .foregroundStyle(.white)
        .task {
            if let _ = imageURL, isLoading {
                retrievePhotos()
            }
        }
    }
    
    func imageView() -> some View {
        ZStack {
            if let _ = imageURL {
                Image(uiImage: retrievedImage)
                    .resizable()
            } else {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(.blue)
            }
        }
        .frame(width: .infinity)
        .frame(height: 350)
        .cornerRadius(10)
        .padding(.horizontal, 10)
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
        HStack {
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
            Spacer()
        }
        .padding(.horizontal, 15)
    }
    
    // this is redundant to create a view model for this function, therefore i use this func here
    func retrievePhotos() {
        isLoading = true
        let storageRef = Storage.storage().reference()
        
        guard let path = imageURL else { return }
        
        let fileRef = storageRef.child(path)
        
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            DispatchQueue.main.async {
                if let imageData = data, error == nil {
                    self.retrievedImage = UIImage(data: imageData) ?? UIImage()
                    self.isLoading = false
                } else {
                    self.isLoading = false
                }
            }
        }
    }
}
