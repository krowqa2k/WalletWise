//
//  TransactionViewModel.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published private(set) var transactions: [TransactionModel] = []
    var userExpenses: Double {
        transactions.reduce(0) { $0 + $1.price }
    }
    
    init(){
        getExpenses()
    }
    
    let expenseKey: String = "expense_item"
    
    func addTransaction(name: String, price: Double, category: TransactionCategory, date: Date) {
        let newTransaction = TransactionModel(name: name, category: category, price: price, date: date)
        transactions.append(newTransaction)
        transactions.sort(by:  { $0.date > $1.date })
        saveExpenses()
    }
    
    func saveExpenses() {
        if let encodedData = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.setValue(encodedData, forKey: expenseKey)
        }
    }
    
    func getExpenses() {
        guard let data = UserDefaults.standard.data(forKey: expenseKey),
              let savedExpenses = try? JSONDecoder().decode([TransactionModel].self, from: data)
        else { return }
        
        self.transactions = savedExpenses
        self.transactions.sort(by: { $0.date > $1.date })
    }
    
    func deleteExpense(indexSet: IndexSet){
        transactions.remove(atOffsets: indexSet)
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
