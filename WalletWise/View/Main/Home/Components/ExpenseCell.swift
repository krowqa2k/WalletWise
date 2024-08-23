//
//  ExpenseCell.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

struct ExpenseCell: View {
    
    let width: CGFloat = UIScreen.main.bounds.width
    @State private var userExpense: Double = 42.00
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.textWW)
                .frame(width: (width / 2) - 20 , height: 120)
            
            HStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(.expenseWW.opacity(0.3))
                        .frame(width: 80, height: 80)
                    Image(systemName: "arrowshape.down.fill")
                        .foregroundStyle(.expenseWW)
                        .font(.title)
                        .rotationEffect(.degrees(50))
                }
                
                Spacer(minLength: 0)
                VStack(alignment: .leading) {
                    Text("-\(userExpense.formatted())%")
                        .foregroundStyle(.expenseWW)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Text("Expense")
                        .foregroundStyle(.backgroundWW)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }
            .frame(width: (width / 2.4) - 20 , height: 140)
        }
    }
}

#Preview {
    ExpenseCell()
}
