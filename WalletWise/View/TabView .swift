//
//  TabView .swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import SwiftUI

struct TabView: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack {
            Button {
                self.index = 0
            } label: {
                Image(systemName: "house.fill")
                    .font(.title2)
            }
            .foregroundStyle(self.index == 0 ? .expenseWW : .white)
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 1
            } label: {
                Image(systemName: "creditcard.fill")
                    .font(.title2)
            }
            .foregroundStyle(self.index == 1 ? .expenseWW : .white)
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 2
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.expenseWW)
                    
                    Image(systemName: "plus")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.textWW)
                }
            })
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 3
            } label: {
                Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    .font(.title2)
            }
            .foregroundStyle(self.index == 2 ? .expenseWW : .white)
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 4
            } label: {
                Image(systemName: "person.fill")
                    .font(.title2)
            }
            .foregroundStyle(self.index == 3 ? .expenseWW : .white)
        }
        .padding(.horizontal, 35)
        .background(Color.backgroundWW)
    }
}

#Preview {
    TabView(index: .constant(0))
}
