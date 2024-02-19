//
//  UserDefaultsHelper.swift
//  Marketore
//
//  Created by Denis Sinitsa on 19.02.2024.
//

import SwiftUI

enum UserDefaultKeys: String, CaseIterable {
    case productCategory
    case productSubcategory
}

final class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    private init() {}
    
    func setData<T>(value: T, key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    
    func getData<T>(type: T.Type, forKey: UserDefaultKeys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }
    
    func removeData(key: UserDefaultKeys) {
       let defaults = UserDefaults.standard
       defaults.removeObject(forKey: key.rawValue)
    }
}
