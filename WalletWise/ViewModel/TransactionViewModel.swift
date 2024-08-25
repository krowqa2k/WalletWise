//
//  TransactionViewModel.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published var transactions: [TransactionModel] = []
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
}
