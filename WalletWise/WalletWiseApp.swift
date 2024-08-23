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
    
    var body: some Scene {
        WindowGroup {
            HomeView(index: 0)
                .environmentObject(viewModel)
        }
    }
}
