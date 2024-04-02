//
//  CellView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.03.2024.
//

import SwiftUI
import FirebaseStorage
import Kingfisher

struct CellView: View {
    @State var productId: String
    @State var title: String?
    @State var imageURL: String?
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                if let imageURL = imageURL {
                    KFImage(URL(string: imageURL))
                        .resizable()
                        .onSuccess { _ in
                            print("Image with product ID: \(String(describing: productId)) has been loaded")
                        }
                        .onFailure { _ in
                            print("Image with product ID: \(String(describing: productId)) can't be loaded")
                        }
                        .frame(width: 160, height: 180)
                        .cornerRadius(10)
                    
                    Text(title ?? "Title")
                        .font(.system(size: 15))
                        .bold()
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
        }
    }
}
