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
    @Binding var isFirstLaunching: Bool
    
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
                
                // 온보딩 완료 버튼.
                // AppStorage의 isFirstLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
                Button {
                    isFirstLaunching.toggle()
                } label: {
                    Text("밤정리 시작하기")
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "1C1C1E"))
                        .frame(width: 358, height: 56)
                        .background(Color(hex: "82EFB8"))
                        .cornerRadius(6)
                }
                .padding()
                
            }
            .padding(.top, -100)
        }
        .ignoresSafeArea()
    }
}
