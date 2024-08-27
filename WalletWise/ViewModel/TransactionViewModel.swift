//
//  TransactionViewModel.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import Foundation
import CoreData

class TransactionViewModel: ObservableObject {
    
    @Published private(set) var transactions: [TransactionModel] = []
    private let transactionsDataManager = TransactionsManager()
    
    var userExpenses: Double {
        transactions.reduce(0) { $0 + $1.price }
    }
    
    init(){
        fetchTransactionsFromCoreData()
    }
    
    func addTransaction(name: String, price: Double, category: TransactionCategory, date: Date) {
        let newTransaction = TransactionModel(name: name, category: category, price: price, date: date)
        transactionsDataManager.addTransaction(transaction: newTransaction)
        fetchTransactionsFromCoreData()
    }
    
    func fetchTransactionsFromCoreData() {
        transactionsDataManager.fetchTransactions()
        self.transactions = transactionsDataManager.savedEntities.map { entity in
            TransactionModel(id: entity.id ?? UUID().uuidString,
                             name: entity.name ?? "",
                             category: TransactionCategory(rawValue: entity.category ?? "") ?? .shopping,
                             price: entity.price,
                             date: entity.date ?? Date())
        }
    }
    
    func groupTransactionByDay() -> [Date: [TransactionModel]] {
        guard !transactions.isEmpty else { return [:] }
        
        let groupedTransactions = Dictionary(grouping: transactions, by: { transaction -> Date in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year,.month,.day], from: transaction.date)
            
            return calendar.date(from: components) ?? transaction.date
        })
        
        return groupedTransactions
    }
    
    func deleteExpense(indexSet: IndexSet) {
        transactionsDataManager.deleteTransaction(indexSet: indexSet)
        fetchTransactionsFromCoreData()
    }
    
    func removeAll() {
        transactionsDataManager.removeAllTransactions()
        fetchTransactionsFromCoreData()
    }
    
    func sumTransactionsForDay(date: Date) -> Double {
        let calendar = Calendar.current
        let transactionsForDay = transactions.filter({ transaction in
            return calendar.isDate(transaction.date, inSameDayAs: date)
        })
        
        return transactionsForDay.reduce(0) { $0 + $1.price }
    }
    
    func sumTransactionsForWeek(date: Date) -> Double {
        let calendar = Calendar.current
        let weekOfTheYear = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.yearForWeekOfYear, from: date)
        
        let transactionsForTheWeek = transactions.filter({ transaction in
            let transactionWeek = calendar.component(.weekOfYear, from: transaction.date)
            let transactionYear = calendar.component(.yearForWeekOfYear, from: transaction.date)
            
            return transactionWeek == weekOfTheYear && transactionYear == year
        })
        
        return transactionsForTheWeek.reduce(0) { $0 + $1.price }
    }
    
    func sumTransactionsForMonth(date: Date) -> Double {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let transactionsForMonth = transactions.filter({ transaction in
            let transactionMonth = calendar.component(.month, from: transaction.date)
            let transactionYear = calendar.component(.year, from: transaction.date)
            return transactionMonth == month && transactionYear == year
        })
        
        return transactionsForMonth.reduce(0) { $0 + $1.price }
    }
}
