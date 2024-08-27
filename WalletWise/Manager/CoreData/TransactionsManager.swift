//
//  TransactionsManager.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 27/08/2024.
//

import Foundation
import CoreData

class TransactionsManager {
    
    @Published private(set) var savedEntities: [TransactionEntity] = []
    
    private let container: NSPersistentContainer
    private let containerName: String = "TransactionsContainer"
    private let entityName: String = "TransactionEntity"
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading CORE DATA \(error)")
            }
        }
        fetchTransactions()
    }
    
    func fetchTransactions() {
        let request = NSFetchRequest<TransactionEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    func addTransaction(transaction: TransactionModel) {
        let entity = TransactionEntity(context: container.viewContext)
        entity.id = transaction.id
        entity.name = transaction.name
        entity.category = transaction.category.rawValue
        entity.price = transaction.price
        entity.date = transaction.date
        
        applyChanges()
    }
    
    func deleteTransaction(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    func removeAllTransactions() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try container.viewContext.execute(deleteRequest)
            saveData()
        } catch let error {
            print("Error deleting all transactions. \(error)")
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchTransactions()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    private func applyChanges() {
        saveData()
        fetchTransactions()
    }
}
