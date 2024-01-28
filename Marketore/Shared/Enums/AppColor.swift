//
//  AppColor.swift
//  Marketore
//
//  Created by Denis Sinitsa on 28.01.2024.
//

import SwiftUI

enum AppColor {
    case purpleColor
    case whiteColor
    
    var associatedColor: UIColor {
        switch self {
        case .purpleColor:
            return UIColor(.purple.opacity(0.8))
        case .whiteColor:
            return UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        }
    }
}

extension Color {
    init(appColor: AppColor) {
        self.init(uiColor: appColor.associatedColor)
    }
}
