//
//  SnackBar.swift
//  Marketore
//
//  Created by Denis Sinitsa on 04.03.2024.
//

import SwiftUI

struct SnackBar: View {
    @Binding var isShowing: Bool
    
    var message: String

    var body: some View {
        ZStack {
            if isShowing {
                HStack(alignment: .firstTextBaseline) {
                    Text(message)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color(appColor: .whiteColor))
                .cornerRadius(15)
                .frame(width: 400, height: 80)
            }
        }
    }
}
