//
//  OnboardingNickNameView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct OnboardingNickNameView: View {

    @EnvironmentObject var data: DataModel
    @Binding var isSecondLaunching: Bool

    var body: some View {

        NavigationView {
            ZStack {
                Color(hex: "#1C1C1E")
                    .edgesIgnoringSafeArea(.all)

                VStack {

                    Text("당신의 이름을 알려주세요.")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 38)

                    Form {
                        TextField("닉네임을 입력해주세요", text : $data.name)
                            .frame(height: 45)
                    }
                    .scrollDisabled(true)
                    .frame(height: 140, alignment: .center)

                    Text("\(data.name)의 방문을 환영합니다")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Spacer()

//                    VStack {
//                        if data.name .isEmpty {
//                            NavigationLink(destination: OnboardingAlarmTimeView(isSecondLaunching: $isSecondLaunching ).navigationBarHidden(true)) {
//                                Text("작성 완료")
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color(hex: "FFFFFF"))
//                                    .frame(width: 358, height: 56)
//                                    .background(Color(hex: "9C9C9C"))
//                                    .cornerRadius(14)
//                            }
//                            .disabled(data.name.isEmpty)
//                        } else {
//                            NavigationLink(destination: OnboardingAlarmTimeView(isSecondLaunching: $isSecondLaunching)) {
//                                Text("작성 완료")
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color(hex: "FFFFFF"))
//                                    .frame(width: 358, height: 56)
//                                    .background(Color(hex: "5E5CE6"))
//                                    .cornerRadius(14)
//                            }
//                        }
//                    }
                    
                    VStack { //알림 시간 설정 기능 제거
                        if data.name.isEmpty {
                            Button {
                                
                            } label: {
                                Text("작성 완료")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "FFFFFF"))
                                    .frame(width: 358, height: 56)
                                    .background(Color(hex: "9C9C9C"))
                                    .cornerRadius(14)
                            }.disabled(data.name.isEmpty)
                        }
                        else {
                            Button {
                                isSecondLaunching.toggle()
                            } label: {
                                Text("작성 완료")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "FFFFFF"))
                                    .frame(width: 358, height: 56)
                                    .background(Color(hex: "5E5CE6"))
                                    .cornerRadius(14)
                            }
                        }
                    }
                }
                // 다음 페이지로 이동하기
            }
        }
        .onDisappear {
            defaults.set(data.name, forKey: "username")
            defaults.set(300, forKey: "timer")
        }
    }
}
