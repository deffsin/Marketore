//
//  CellView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.03.2024.
//

import SwiftUI
import FirebaseStorage

struct CellView: View {
    @State var title: String?
    @State var imageURL: String?
    @State var retrievedImage = UIImage()
    @State var isLoading = true
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .frame(width: 160, height: 180)
            } else {
                VStack(spacing: 5) {
                    if let imageURL = imageURL {
                        Image(uiImage: retrievedImage)
                            .resizable()
                            .frame(width: 160, height: 180)
                            .cornerRadius(10)
                    } else {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(.blue)
                            .frame(width: 160, height: 180)
                            .cornerRadius(10)
                    }
                    
                    Text(title ?? "Title")
                        .font(.system(size: 15))
                        .bold()
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
        }
        .task {
            if let _ = imageURL, isLoading {
                retrievePhotos()
            }
        }
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

#Preview {
    CellView()
}
