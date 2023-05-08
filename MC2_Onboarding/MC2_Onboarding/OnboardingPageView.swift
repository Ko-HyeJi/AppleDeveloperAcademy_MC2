//
//  OnboardingPageView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct OnboardingPageView: View {
    let title: String
    let title2: String
    let subtitle: String
    
    var body: some View {
        ZStack {
            Color(hex: "#1C1C1E")
                .ignoresSafeArea()
            VStack {
                Text(title)
                    .frame(width: 300)
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, -80)
                Text(title2)
                    .frame(width: 300)
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                Text(subtitle)
                    .frame(width: 250)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, -180)
        }
       
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(
            title: "00",
            title2: "00",
            subtitle: "24시간 중 단 1%\n 15분동안 정리할 곳을 정해"
        )
    }
}
