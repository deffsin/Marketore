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
    @State var title: String?
    @State var imageURL: String?
    @State var retrievedImage = UIImage()
    @State var isLoading = true
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                if let imageURL = imageURL {
                    KFImage(URL(string: imageURL))
                        .resizable()
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

#Preview {
    CellView()
}
