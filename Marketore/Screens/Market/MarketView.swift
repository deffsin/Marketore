//
//  MarketView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

struct MarketView: View {
    @ObservedObject var viewModel: MarketViewModel
    
    var body: some View {
        Text("MarketView")
    }
}

#Preview {
    MarketView(viewModel: MarketViewModel())
}
