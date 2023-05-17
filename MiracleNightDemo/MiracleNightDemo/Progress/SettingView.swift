//
//  SettingView.swift
//  MiracleNightDemo
//
//  Created by 장수민 on 2023/05/16.
//

import SwiftUI

struct SettingView: View {
    @State var name: String = ""
    @State var timerMin: Int = 0
    
    @State var isClicked: Bool = false
    @State var showOnboarding: Bool = false
    
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        ZStack {
            Color(hex: "1c1c1e")
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    HStack {
                        Button {
                            router.popToRoot()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 13, height: 15)
                                .padding(.leading)
                            .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    Text("설정")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding(.bottom, 32)
            
                SetNameView(name: $name)
                
                SetTimerView(timerMin: $timerMin, isClicked: $isClicked)
                
                CallOnboardingView(showOnboarding: $showOnboarding)
                
                Spacer()

            }
            .padding(.horizontal, 8)
            .padding(.vertical)
            
            SpeechBubbleView(isClicked: $isClicked)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            name = data.userName
            timerMin = data.timerSec / 60
        }
        .onDisappear {
            if name != "" {
                data.userName = name
            }
            data.timerSec = timerMin * 60
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct SetNameView: View {
    @Binding var name: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 68)
                .foregroundColor(Color(hex: "3d3d3d"))
                .padding(.bottom, 4)
                .overlay {
                    HStack {
                        Text("이름")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                }
            
            HStack {
                Spacer(minLength: 200)
                TextField("\(name)", text: $name)
                    .frame(width: 150)
                    .multilineTextAlignment(.trailing)
                    .bold()
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                Spacer()
                Button {
                    name = ""
                } label: {
                    Image("ExitButton")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing)
                }
            }
        }
    }
}

struct SetTimerView: View {
    @Binding var timerMin: Int
    @Binding var isClicked: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(height: 68)
            .foregroundColor(Color(hex: "3d3d3d"))
            .padding(.bottom, 4)
            .overlay {
                HStack(spacing: 0) {
                    Text("타이머")
                        .foregroundColor(.white)
                        .padding(.trailing, 4)
                        .fontWeight(.semibold)
                   
                    Button {
                        isClicked = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isClicked = false
                        }
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        if timerMin > 1 {
                            timerMin -= 1
                        }
                    } label: {
                        Image("Minus")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Text(String(format: "%02d", timerMin))
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    .padding(.horizontal, 17)
                    
                    
                    Button {
                        if timerMin < 15 {
                            timerMin += 1
                        }
                    } label: {
                        Image("Plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
            }

    }
}

struct CallOnboardingView: View {
    @Binding var showOnboarding: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(height: 68)
            .foregroundColor(Color(hex: "3d3d3d"))
            .padding(.bottom, 4)
            .overlay {
                HStack {
                    Text("앱 소개")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: OnboardingTabView().navigationBarBackButtonHidden(true)) {
                            Text("다시보기")
                                .foregroundColor(.white)
                        }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
            }
    }
}

struct SpeechBubbleView: View {
    @Binding var isClicked: Bool
    
    var body: some View {
        Image("SpeechBubble_2")
            .resizable()
            .frame(width: 247, height: 55)
            .overlay {
                Text("최소 1분 최대 15분까지 설정 가능해요!")
                    .font(.system(size: 13))
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
            .opacity(isClicked ? 1 : 0)
            .position(x: 150, y: 235)
    }
}
