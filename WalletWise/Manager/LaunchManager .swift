//
//  LaunchManager .swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 26/08/2024.
//

import Foundation

class LaunchManager {
    private static let isFirstLaunchKey = "isFirstLaunch"
    
    static var isFirstLaunch: Bool {
        get {
            return !UserDefaults.standard.bool(forKey: isFirstLaunchKey)
        }
        set {
            UserDefaults.standard.set(!newValue, forKey: isFirstLaunchKey)
        }
    }
}

