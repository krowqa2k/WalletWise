//
//  AddTransactionView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import SwiftUI

struct AddTransactionView: View {
    
    @EnvironmentObject private var viewModel: TransactionViewModel
    @State private var transactionName: String = ""
    @State private var transactionCategory: TransactionCategory = .shopping
    @State private var transactionPrice: String = ""
    @State private var transactionDate: Date? = .now
    @Binding var index: Int
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Add Transaction 💳")
                        .foregroundStyle(.expenseWW)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        saveButton()
                        self.index = 0
                    }, label: {
                        Image(systemName: "bag.badge.plus")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.expenseWW)
                    })
                }
                .padding(.horizontal)
                
                Form {
                    Section("NAME") {
                        TextField("...", text: $transactionName)
                    }
                    
                    
                    Section("CATEGORY") {
                        Picker("Select category:", selection: $transactionCategory) {
                            ForEach(TransactionCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                    }
                    
                    Section("AMOUNT") {
                        TextField("$", text: $transactionPrice)
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Button("Done") {
                                        isFocused = false
                                    }
                                    .font(.headline)
                                    .foregroundStyle(.expenseWW)
                                }
                            }
                    }
                    
                    Section("Date of transaction") {
                        DatePicker("Select Date",
                            selection: Binding(
                            get: { transactionDate ?? .now },
                            set: { transactionDate = $0 }),
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                    }
                }
                .font(.subheadline)
                .foregroundStyle(.expenseWW)
                .tint(.expenseWW)
                
                Spacer(minLength: 0)
            }
        }
    }
    
    func saveButton() {
        guard transactionDate != nil else {
            print("Date not selected")
            return
        }
        
        guard !transactionName.isEmpty else { return }
        
        let sanitizedAmount = transactionPrice.replacingOccurrences(of: ",", with: ".")
        if let amount = Double(sanitizedAmount) {
            viewModel.addTransaction(name: transactionName, price: amount, category: transactionCategory, date: transactionDate ?? .now)
        } else {
            print("Invalid amount entered")
        }
    }
    
}

#Preview {
    AddTransactionView(index: .constant(2))
        .environmentObject(TransactionViewModel())
}
