//
//  HomeView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: TransactionViewModel
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
                    AddTransactionView(index: $index)
                case 3:
                    StatisticsView()
                case 4:
                    UserView()
                default:
                    homeView
                }
                
                Spacer(minLength: 0)
                
                TabView(index: $index)
                    .frame(height: 30)
            }
        }
    }
    
    private var homeView: some View {
        VStack(spacing: 26) {
            headerView()
            
            BalanceView_()
            
            HStack {
                DailyExpenses()
                WeeklyExpenses()
                MonthlyExpenses()
            }
            
            recentTransactions
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight: .infinity)
        }
        .padding(.bottom)
    }
    
    private var recentTransactions: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Recent Transactions")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.leading)
            
            ScrollView(.vertical) {
                ForEach(viewModel.transactions.prefix(12)){ transaction in
                    TransactionCell(transaction: transaction)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    HomeView(index: 0)
        .environmentObject(TransactionViewModel())
}
