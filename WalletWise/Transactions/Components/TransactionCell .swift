//
//  TransactionCell .swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import SwiftUI

struct TransactionCell_: View {
    
    private var transaction: TransactionModel = .mock
    private let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 16)
                .frame(width: width - 40, height: 80)
            
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.backgroundWW.opacity(0.1))
                    Image(systemName: transaction.category.transactionImage)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.random)
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text(transaction.name)
                        .font(.headline)
                        .foregroundStyle(.backgroundWW)
                    
                    Text(transaction.date.displayFormat)
                        .foregroundStyle(.backgroundWW)
                }
                Spacer()
                HStack(spacing: 0) {
                    Text("$")
                    Text(String(format: "%.2f", transaction.price))
                }
                .font(.headline)
                .foregroundStyle(.backgroundWW)
            }
            .frame(width: width - 80, height: 80, alignment: .leading)
        }
    }
}

#Preview {
    TransactionCell_()
}
