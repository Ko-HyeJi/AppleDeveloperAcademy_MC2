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
        NavigationView {
            TabView {
                // 페이지 1: 앱 컨셉 안내
                OnboardingPageView(
                    title: "24",
                    title2: "01",
                    subtitle: "24시간 중 단 1%\n 15분동안 정리할 곳을 정해보세요."
                )
                
                // 페이지 2: 앱 사용시간 안내
                OnboardingPageView(
                    title: "06",
                    title2: "00",
                    subtitle: "오후 6시부터 12시까지\n실행가능해요\n\n*다크모드를 권장합니다*"
                )
                
                // 페이지 3: 앱 목표
                OnboardingPageView(
                    title: "Better",
                    title2: "Begin",
                    subtitle: " 더 나은 내일을 위해\n방정리를 사진으로 기록해줘요."
                    
                )
                
                //페이지 4: 앱 이름공개
                OnboardingLastPageView(
                    title: "Night",
                    title2: "Ritual",
                    subtitle: " 하루를 마무리하는\n당신의 방정리를 도와주는",
                    
                    isFirstLaunching: $isFirstLaunching
                )
                
                //페이지 5: 닉네임 설정 + 온보딩 완료
    //            OnboardingNickNameView()
            }
            .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea()
        }
    }
}
