//
//  IncomeCell.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

struct DailyExpenses: View {
    
    @EnvironmentObject private var viewModel: TransactionViewModel
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        let dailyExpense = viewModel.sumTransactionsForDay(date: Date())
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(.textWW)
                .frame(width: (width / 3) - 10 , height: 100)
            
            VStack(alignment: .center, spacing: 12) {
                Text("Day")
                    .foregroundStyle(.black)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                
                Text("$\(dailyExpense.formatted())")
                    .foregroundStyle(.expenseWW)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundWW.ignoresSafeArea()
        DailyExpenses()
            .environmentObject(TransactionViewModel())
    }
}
