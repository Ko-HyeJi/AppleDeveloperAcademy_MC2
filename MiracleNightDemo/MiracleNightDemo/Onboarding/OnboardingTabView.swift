//
//  OnboardingTabView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct OnboardingTabView: View {
    @Binding var isFirstLaunching: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    // 페이지 1: 앱 컨셉 안내
                    OnboardingPageView(
                        uppertitle: "24",
                        lowertitle: "01",
                        subtitle: "24시간 중 단 1%\n 5분동안 정리할 곳을 정해보세요."
                    )
                    
                    // 페이지 2: 앱 사용시간 안내
                    OnboardingPageView(
                        uppertitle: "06",
                        lowertitle: "00",
                        subtitle: "밤정리는 오후 6시부터 밤 12시까지\n실행가능해요."
                    )
                    
                    // 페이지 3: 앱 목표
                    OnboardingPageView(
                        uppertitle: "Better",
                        lowertitle: "Begin",
                        subtitle: " 더 나은 내일을 위해\n정리된 공간을 사진으로 기록해줘요."
                        
                    )
                    
                    //페이지 4: 앱 이름공개
                    OnboardingLastPageView(
                        uppertitle: "Night",
                        lowertitle: "Ritual",
                        subtitle: " 공간을 정리하며\n하루를 마무리하는 ",
                        
                        isFirstLaunching: $isFirstLaunching
                    )
                    
                    //페이지 5: 닉네임 설정 + 온보딩 완료
        //            OnboardingNickNameView()
                }
                
                VStack { //설정에서 다시보기로 들어온 경우에만 보이는 버튼
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 13, height: 15)
                                .foregroundColor(.white)
                                .padding()
                                .padding(.top, 50)
                        }
                        Spacer()
                    }.opacity(isFirstLaunching ? 0 : 1)
                    Spacer()
                }
                
            }
            .tabViewStyle(PageTabViewStyle())
            .edgesIgnoringSafeArea(.all)
        }
    }
}
