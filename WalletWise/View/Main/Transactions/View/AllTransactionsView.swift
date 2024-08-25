//
//  AllTransactionsView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import SwiftUI

struct AllTransactionsView: View {
    
    @EnvironmentObject private var viewModel: TransactionViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            VStack {
                HStack {
                    Text("All Transactions")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.expenseWW)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "creditcard.fill")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.expenseWW)
                }
                .padding(.horizontal)
                
                List {
                    let groupedTransactions = viewModel.groupTransactionByDay()
                    
                    if groupedTransactions.isEmpty {
                        Text("No Transactions Available")
                    } else {
                        ForEach(groupedTransactions.keys.sorted(by: >), id: \.self) { date in
                            Section(header: Text(date, style: .date)) {
                                ForEach(groupedTransactions[date] ?? []) { transaction in
                                    TransactionListCell(transaction: transaction)
                                }
                                .onDelete(perform: viewModel.deleteExpense)
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    AllTransactionsView()
        .environmentObject(TransactionViewModel())
}
