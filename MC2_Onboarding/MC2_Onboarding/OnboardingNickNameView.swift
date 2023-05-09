//
//  OnboardingNickNameView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct OnboardingNickNameView: View {
    
    @State private var nickName = ""
    @Binding var isSecondLaunching: Bool
    
    var body: some View {
        
        ZStack {
            Color(hex: "#1C1C1E")
            VStack {
                Form {
                    TextField("닉네임을 입력해주세요", text : $nickName)
                        .frame(height: 45)
                }
                    .frame(height: 140)
                Text("\(nickName) 의 방문을 환영합니다")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // 온보딩 완료 버튼.
                // AppStorage의 isSecondLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
                Button {
                    isSecondLaunching.toggle()
                } label: {
                    Text("결정")
                        .fontWeight(.bold)
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}
