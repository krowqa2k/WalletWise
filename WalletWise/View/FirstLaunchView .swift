//
//  FirstLaunchView .swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 26/08/2024.
//

import SwiftUI

struct FirstLaunchView: View {
    
    @State private var userName: String = ""
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        ZStack {
            background
            
            VStack(spacing: 24) {
                Text("WALLET WISE")
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                    .foregroundStyle(.expenseWW)
                    .fontDesign(.serif)
                
                TextField("Your Name...", text: $userName)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.cardWW)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .tint(.expenseWW)
                
                Button(action: handleSubmit) {
                    Text("Submit")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.expenseWW)
                        .cornerRadius(10)
                        .padding(.top, -30)
                }
                .padding()
            }
            .offset(y: 100)
        }
    }
    
    private var background: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.backgroundWW,
                        Color.secondary.opacity(0.3),
                        Color.secondary.opacity(0.1)
                    ]),
                startPoint: .top,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ZStack {
                Circle()
                    .frame(width: 380, height: 380)
                    .foregroundStyle(LinearGradient(colors: [Color.red, Color.expenseWW], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .offset(x: 180, y: -320)
                
                cardView
            }
        }
    }
    
    private var cardView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 300, height: 180)
                .rotationEffect(Angle(degrees: -5))
                .foregroundStyle(.ultraThinMaterial)
                .offset(y: -120)
            
            VStack(spacing: 12) {
                HStack(spacing: -20) {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(LinearGradient(colors: [Color.red, Color.red, Color.red, Color.expenseWW], startPoint: .leading, endPoint: .trailing))
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(LinearGradient(colors: [Color.expenseWW, Color.red], startPoint: .trailing, endPoint: .leading))
                }
                
                Text("My Wallet")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textWW)
                
                HStack(spacing: 24) {
                    ForEach(1..<4) { segment in
                        HStack {
                            ForEach(1..<5) { star in
                                Text("*")
                                    
                            }
                        }
                    }
                }
                .font(.title)
                .foregroundStyle(.textWW)
                .offset(x: 80)
            }
            .offset(x: -70, y: -120)
            .rotationEffect(Angle(degrees: -5))
        }
    }
    
    private func handleSubmit() {
        if !userName.isEmpty {
            userSettings.userName = userName
            LaunchManager.isFirstLaunch = false
        }
    }
}



#Preview {
    FirstLaunchView()
}
