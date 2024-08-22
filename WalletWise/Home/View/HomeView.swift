//
//  HomeView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            
            VStack(spacing: 16) {
                headerView()
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
