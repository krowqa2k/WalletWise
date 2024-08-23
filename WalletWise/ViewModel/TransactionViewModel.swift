//
//  TransactionViewModel.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published var transactions: [TransactionModel] = []
    @Published var recentTransactions: [TransactionModel] = []
    
    func addTransaction(name: String, price: Double, category: TransactionCategory, date: Date) {
        let newTransaction = TransactionModel(name: name, category: category, price: price, date: date)
        transactions.append(newTransaction)
        recentTransactions.append(newTransaction)
        transactions.sort(by:  { $0.date > $1.date })
        recentTransactions.sort(by: {$0.date > $1.date })
    }
}
