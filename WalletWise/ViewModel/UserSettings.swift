//
//  UserSettings.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 26/08/2024.
//

import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @Published var userName: String {
        didSet {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }

    init() {
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? ""
    }
}


