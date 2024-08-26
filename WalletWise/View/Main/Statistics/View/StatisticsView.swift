//
//  StatisticsView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import SwiftUI
import SwiftUICharts

struct StatisticsView: View {
    
    @EnvironmentObject private var viewModel: TransactionViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            VStack(spacing: 12) {
                Text("Statistics")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(.expenseWW)
                
                VStack {
                    Text("$")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundStyle(.expenseWW)
                    +
                    Text(String(format: "%.2f", viewModel.userExpenses))
                        .font(.title)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                        .foregroundStyle(.expenseWW)
                    
                    Text(Date().displayFormat)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity, alignment: .center)
                
                LineChartView()
                    .frame(height: 300)
                    .padding(.horizontal)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("Top Spendings")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.expenseWW)
                        .padding(.leading)
                    
                    ScrollView(.vertical) {
                        ForEach(viewModel.transactions.sorted(by: { $0.price > $1.price }).prefix(5)) { transaction in
                            TopSpendingCell(transaction: transaction)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
            }
        }
    }
}

#Preview {
    StatisticsView()
        .environmentObject(TransactionViewModel())
}
