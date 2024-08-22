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
            
            VStack(spacing: 28) {
                headerView()
                
                BalanceView_()
                
                HStack {
                    IncomeCell()
                    ExpenseCell()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
