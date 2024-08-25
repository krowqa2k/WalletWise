//
//  ExpenseCell.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

struct WeeklyExpenses: View {
    
    @EnvironmentObject private var viewModel: TransactionViewModel
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        let weeklyExpense = viewModel.sumTransactionsForWeek(date: Date())
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(.textWW)
                .frame(width: (width / 3) - 10 , height: 100)
            
            VStack(alignment: .center, spacing: 12) {
                Text("Week")
                    .foregroundStyle(.black)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                
                Text("$\(weeklyExpense.formatted())")
                    .foregroundStyle(.expenseWW)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    WeeklyExpenses()
        .environmentObject(TransactionViewModel())
}
