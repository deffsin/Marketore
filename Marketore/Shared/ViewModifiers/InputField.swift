//
//  InputField.swift
//  Marketore
//
//  Created by Denis Sinitsa on 25.02.2024.
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    
    var title: String
    var isValid: Bool?
    var errorMessage: String?
    var keyboardType: UIKeyboardType = .default
    var titleInsideOfTextField: String {
        get { title }
        set { title = newValue }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(title)
                .foregroundColor(.white)
                .bold()
            
            TextField(titleInsideOfTextField, text: $text)
                .padding(10)
                .background(.white)
                .frame(width: 220, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isValid == false ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                )
                .keyboardType(keyboardType)
                .overlay(
                    showingError()
                        .offset(y: 35)
                )
        }
        .font(.system(size: 14))
    }
    
    func showingError() -> some View {
        VStack {
            if let errorMessage = errorMessage, !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.system(size: 9))
                    .foregroundStyle(.red)
            }
        }
    }
}
