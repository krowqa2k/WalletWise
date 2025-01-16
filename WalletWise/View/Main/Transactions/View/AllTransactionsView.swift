//
//  AllTransactionsView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import SwiftUI

struct AllTransactionsView: View {
    
    @EnvironmentObject private var viewModel: TransactionViewModel
    @State private var showAlert: Bool = false
    
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
                    
                    Button(action: {
                        showAlert.toggle()
                    }, label: {
                        Text("Remove All")
                            .font(.headline)
                            .foregroundStyle(.red)
                    })
                    
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
        .alert("Are You Sure?", isPresented: $showAlert) {
            Button("Delete", role: .destructive) {
                viewModel.removeAll()
            }
            
            Button("Cancel", role: .cancel) { }
        }
    }
}

#Preview {
    AllTransactionsView()
        .environmentObject(TransactionViewModel())
}
