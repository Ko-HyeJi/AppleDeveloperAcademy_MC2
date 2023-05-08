//
//  OnboardingLastPageView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct OnboardingLastPageView: View {
    let title: String
    let title2: String
    let subtitle: String
    
    var body: some View {
        ZStack {
            Color(hex: "#1C1C1E")
            VStack {
                Text(title)
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, -80)
                Text(title2)
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
            }
            .padding(.top, -100)
        }
        .ignoresSafeArea()
    }
}
