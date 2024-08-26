//
//  WalletWiseApp.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

@main
struct WalletWiseApp: App {
    
    @StateObject private var viewModel = TransactionViewModel()
    @StateObject private var userSettings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            if LaunchManager.isFirstLaunch {
                FirstLaunchView()
                    .environmentObject(userSettings)
                    .environmentObject(viewModel)
            } else {
                HomeView(index: 0)
                    .environmentObject(viewModel)
                    .environmentObject(userSettings)
            }
        }
    }
}
