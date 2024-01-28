//
//  SettingsView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            Button(action: {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }) {
                Text("Log out")
                    .bold()
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(), showSignInView: .constant(false))
}
