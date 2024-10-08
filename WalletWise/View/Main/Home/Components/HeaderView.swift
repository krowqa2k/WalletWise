//
//  HeaderView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 22/08/2024.
//

import SwiftUI

struct headerView: View {
    
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hello!")
                    .foregroundStyle(.textWW.opacity(0.5))
                    .font(.callout)
                
                Text(userSettings.userName.isEmpty ? "" : userSettings.userName)
                    .foregroundStyle(.textWW)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.expenseWW)
                    .frame(width: 30, height: 30)
                
                Image(systemName: "dollarsign")
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.backgroundWW.ignoresSafeArea()
        headerView()
            .environmentObject(UserSettings())
    }
}
