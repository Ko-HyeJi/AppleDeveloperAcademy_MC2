//
//  OnboardingLastPageView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct OnboardingLastPageView: View {
    let uppertitle: String
    let lowertitle: String
    let subtitle: String
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        ZStack {
            Image("onboardingBG")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(uppertitle)
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.white)
                    .lineSpacing(-64)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, -80)
                Text(lowertitle)
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                Text(subtitle)
                    .font(.body)
                    .lineSpacing(6)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                
                // 온보딩 완료 버튼.
                // AppStorage의 isFirstLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
                Button {
                    isFirstLaunching.toggle()
                } label: {
                    Text("밤정리 시작하기")
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "FFFFFF"))
                        .frame(width: 358, height: 56)
                        .background(Color(hex: "5E5CE6"))
                        .cornerRadius(14)
                        .padding(.top, 120)
                }
                .padding(.bottom, 85)
            }
            .padding(.top, 60)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
