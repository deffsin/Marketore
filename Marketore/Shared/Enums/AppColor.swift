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
    case darkBackgroundColor
    case darkGrayColor // tab bar
    case lightGrayColor // tab bar
    
    var associatedColor: UIColor {
        switch self {
        case .purpleColor:
            return UIColor(.purple)
        case .whiteColor:
            return UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        case .darkBackgroundColor:
            return UIColor(.black.opacity(0.8))
        case .darkGrayColor:
            return UIColor(red: 0.06, green: 0.06, blue: 0.06, alpha: 1.0)
        case .lightGrayColor:
            return UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.0)
        }
    }
}

extension Color {
    init(appColor: AppColor) {
        self.init(uiColor: appColor.associatedColor)
    }
}
