//
//  UserView.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import SwiftUI

struct AppInfoView: View {
    
    let aboutMe = URL(string: "https://github.com/krowqa2k")!
    
    var body: some View {
        ZStack {
            Color.backgroundWW.ignoresSafeArea()
            
            VStack(spacing: 12) {
                HStack {
                    Text("App Info")
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.expenseWW)
                        .padding(.leading)
                        .padding(.bottom, 50)
                    Image(systemName: "questionmark.square.fill")
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .padding(.bottom, 50)
                }
                Text("Info About Creator")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.expenseWW)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                HStack(spacing: 12) {
                    Image("creatorImage")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.leading)
                    Spacer(minLength: 0)
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("App created by Mateusz Krówczyński.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                        Text("👇 You can reach me here.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        Link("Github profile.", destination: aboutMe)
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    AppInfoView()
}
