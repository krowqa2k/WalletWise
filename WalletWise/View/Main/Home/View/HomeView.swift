//
//  HomeView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = TransactionViewModel()
    @State var index: Int
    
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            VStack {
                switch index {
                case 0:
                    homeView
                case 1:
                    AllTransactionsView()
                case 2:
                    AddTransactionView()
                case 3:
                    StatisticsView()
                case 4:
                    UserView()
                default:
                    homeView
                }
                
                Spacer(minLength: 0)
                
                TabView(index: $index)
            }
        }
    }
    
    private var homeView: some View {
        VStack(spacing: 26) {
            headerView()
            
            BalanceView_()
            
            HStack {
                IncomeCell()
                ExpenseCell()
            }
            
            recentTransactions
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            Spacer()
        }
    }
    
    private var recentTransactions: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Recent Transactions")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.leading)
            
            ScrollView(.vertical) {
                ForEach(viewModel.recentTransactions.prefix(12)){ transaction in
                    TransactionCell_(transaction: transaction)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    HomeView(index: 0)
}
