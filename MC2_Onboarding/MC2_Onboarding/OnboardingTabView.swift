//
//  OnboardingTabView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct OnboardingTabView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
            // 페이지 1: 앱 컨셉 안내
            OnboardingPageView(
                title: "24",
                title2: "01",
                subtitle: "24시간 중 단 1%\n 15분동안 정리할 곳을 정해"
            )
            
            // 페이지 2: 앱 사용시간 안내
            OnboardingPageView(
                title: "06",
                title2: "00",
                subtitle: "오후 6시부터 12시까지\n체크인 가능한\n\n*다크모드를 권장합니다*"
            )
            
            // 페이지 3: 앱 목표
            OnboardingLastPageView(
                title: "Better",
                title2: "Life",
                subtitle: " 하루를 마무리하는\n밤정리"
                
            )
            
            //페이지 4: 닉네임 설정 + 온보딩 완료
            OnboardingNickNameView(
                isFirstLaunching: $isFirstLaunching
            
            )
        }
        .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea()
    }
}
