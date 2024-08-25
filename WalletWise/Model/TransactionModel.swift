//
//  TransactionModel.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import Foundation

struct TransactionModel: Identifiable {
    var id = UUID().uuidString
    let name: String
    let category: TransactionCategory
    let price: Double
    let date: Date

    static var mock: TransactionModel {
        TransactionModel(
            name: "iPhone 15 Pro",
            category: .shopping,
            price: 1099.00,
            date: .now
        )
    }
}

enum TransactionCategory: String, CaseIterable, Identifiable, Codable {
    case groceriesAndFood = "Groceries and Food"
    case rentAndUtilities = "Rent and Utilities"
    case transportation = "Transportation"
    case entertainment = "Entertainment"
    case diningOut = "Dining Out"
    case healthAndFitness = "Health and Fitness"
    case shopping = "Shopping"
    case subscriptions = "Subscriptions"
    case travelAndVacation = "Travel and Vacation"
    case giftsAndDonations = "Gifts and Donations"
    case householdSupplies = "Household Supplies"
    case insurance = "Insurance"
    
    var id: String { self.rawValue }
    
    var transactionImage: String {
        switch self {
        case .groceriesAndFood:
            return "cart.fill"
        case .rentAndUtilities:
            return "house.fill"
        case .transportation:
            return "car.fill"
        case .entertainment:
            return "party.popper.fill"
        case .diningOut:
            return "fork.knife"
        case .healthAndFitness:
            return "heart.fill"
        case .shopping:
            return "bag.fill"
        case .subscriptions:
            return "tv.fill"
        case .travelAndVacation:
            return "airplane"
        case .giftsAndDonations:
            return "gift.fill"
        case .householdSupplies:
            return "wrench.fill"
        case .insurance:
            return "shield.fill"
        }
    }
}
