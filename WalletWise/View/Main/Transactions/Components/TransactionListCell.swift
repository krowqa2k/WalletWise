//
//  TransactionListCell.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 25/08/2024.
//

import SwiftUI

struct TransactionListCell: View {
    var transaction: TransactionModel = .mock
    private let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: width - 40, height: 45)
            
            HStack {
                Image(systemName: transaction.category.transactionImage)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.random)
                
                Text(transaction.name)
                    .font(.headline)
                    .foregroundStyle(.backgroundWW)
                    .lineLimit(1)
                
                Spacer()
                HStack(spacing: 0) {
                    Text("$")
                    Text(String(format: "%.2f", transaction.price))
                }
                .font(.headline)
                .foregroundStyle(.backgroundWW)
            }
            .frame(width: width - 80, height: 45, alignment: .leading)
        }
    }
}

#Preview {
    TransactionListCell()
}
