//
//  SettingView.swift
//  MiracleNightDemo
//
//  Created by 장수민 on 2023/05/16.
//

import SwiftUI

struct SettingView: View {
    @State var yourName = "nickname"
    @State var timerNum: Int = 5
    
    @State var isEditing: Bool = false
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
            
                SetNameView(yourName: $yourName, isEditing: $isEditing)
                
                SetTimerView(timerNum: $timerNum, isClicked: $isClicked)
                
                CallOnboardingView(showOnboarding: $showOnboarding)
                
                Spacer()

            }
            .padding(.horizontal, 8)
            .padding(.vertical)
            
            SpeechBubbleView(isClicked: $isClicked)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if data.name != "" {
                yourName = data.name
            } else {
                yourName = data.username!
            }
            timerNum = data.countTo / 60
        }
        .onDisappear {
            if yourName != "" {
                data.name = yourName
                defaults.set(yourName, forKey: "username")
            }
            data.countTo = timerNum * 60
            defaults.set(timerNum * 60, forKey: "timer")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct SetNameView: View {
    @Binding var yourName: String
    @Binding var isEditing: Bool
    
    var body: some View {
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
                    
                    ZStack(alignment: .trailing) {
                        Text("\(yourName)")  // data.name
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .onTapGesture {
                                isEditing.toggle()
                            }
                        .opacity(isEditing ? 0 : 1)
                        
                        HStack {
//                                    Spacer()
                            
                            TextField("\(yourName)", text:$yourName)  // 여기 data.name이어야 할 것 같아용!!
                                .multilineTextAlignment(.trailing)
                                .frame(alignment: .trailing)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .opacity(isEditing ? 1 : 0)
                                .onTapGesture {
                                    isEditing.toggle()
                            }
                        }
                    }
                    
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
            }
    }
}

struct SetTimerView: View {
    @Binding var timerNum: Int
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
                        if timerNum > 1 {
                            timerNum -= 1
                        }
                    } label: {
                        Image("Minus")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Text(String(format: "%02d", timerNum))
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    .padding(.horizontal, 17)
                    
                    
                    Button {
                        if timerNum < 15 {
                            timerNum += 1
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
                        destination: OnboardingTabView(isFirstLaunching: $showOnboarding).navigationBarBackButtonHidden(true)) {
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
