//
//  ContentView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct ContentView: View {
    // 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수.
    // @AppStorage에 저장되어 앱 종료 후에도 유지됨.
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    @AppStorage("_isSecondLaunching") var isSecondLaunching: Bool = true
    
    var body: some View {
        ZStack {
            Image("mainView")
                .ignoresSafeArea()
            // 앱 최초 구동 시 전체화면으로 OnboardingTabView, OnboardingNickNameView 띄우기
                .fullScreenCover(isPresented: $isFirstLaunching) {
                    OnboardingTabView(isFirstLaunching: $isFirstLaunching)
                }
                .fullScreenCover(isPresented: $isSecondLaunching) {
                    OnboardingNickNameView(isSecondLaunching: $isSecondLaunching)
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

