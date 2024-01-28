//
//  AccountView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    
    var body: some View {
        Text("AccountView")
    }
}

#Preview {
    AccountView(viewModel: AccountViewModel())
}
