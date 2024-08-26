//
//  LineChartView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 26/08/2024.
//

import SwiftUI
import SwiftUICharts

struct LineChartView: View {
    
    @ObservedObject private var viewModel = TransactionViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            
            let chartData = generateChartData()
            
            if !chartData.isEmpty {
                VStack {
                    Text("Expenses from last 7 days")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    LineView(data: chartData.map { $0.1 },
                             title: nil,
                             legend: nil,
                             style: ChartStyle(
                                backgroundColor: Color.backgroundWW,
                                accentColor: Color.expenseWW,
                                secondGradientColor: Color.expenseWW,
                                textColor: Color.clear,
                                legendTextColor: Color.clear,
                                dropShadowColor: Color.clear
                             ),
                             valueSpecifier: "%.2f"
                    )
                    .frame(height: 280)
                    
                    HStack {
                        ForEach(chartData, id: \.0) { dataPoint in
                            Text(dataPoint.0)
                                .font(.caption)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("Brak danych do wyświetlenia.")
                    .foregroundColor(.textWW)
            }
        }
    }
    
    func generateChartData() -> [(String, Double)] {
        let groupedTransactions = viewModel.groupTransactionByDay()
        
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.date(byAdding: .day, value: -6, to: today)!
        
        let sortedDates = groupedTransactions.keys
            .filter { $0 >= startOfWeek }
            .sorted(by: { $0 < $1 })
        
        var chartData: [(String, Double)] = []
        
        for date in sortedDates {
            let dateStr = formatDate(date: date)
            let totalForDay = viewModel.sumTransactionsForDay(date: date)
            chartData.append((dateStr, totalForDay))
        }
        
        return chartData
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM" 
        return formatter.string(from: date)
    }
}

#Preview {
    LineChartView()
}
