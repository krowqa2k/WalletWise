//
//  BalanceView .swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

struct BalanceView_: View {
    
    let width: CGFloat = UIScreen.main.bounds.width
    @EnvironmentObject private var viewModel: TransactionViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: width - 20, height: 180)
                .foregroundStyle(.cardWW)
                .overlay(alignment: .topTrailing) {
                    ZStack {
                        Circle()
                            .fill(.expenseWW)
                            .offset(x: 25, y: -45)
                            .clipped()
                            .cornerRadius(16)
                        
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.backgroundWW)
                            .offset(x: 18, y: -28)
                    }
                }
            
            VStack(alignment: .leading, spacing: 6){
                Text("Your Expenses")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.textWW.opacity(0.6))
                
                Text("$\(viewModel.userExpenses.formatted())")
                    .font(.system(size: 40))
                    .foregroundStyle(.textWW)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
            }
            .frame(maxWidth: width, alignment: .leading)
            .padding(.leading, 35)
            .offset(y: -5)
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundWW.ignoresSafeArea()
        BalanceView_()
            .environmentObject(TransactionViewModel())
    }
}
