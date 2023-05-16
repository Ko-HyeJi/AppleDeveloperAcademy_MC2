//
//  DoNotDisturbView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/05.
//

import SwiftUI
import AVFoundation

struct DoNotDisturbView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            if let beforeImage = viewModel.recentImage {
                Image(uiImage: beforeImage)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.black)
                    .opacity(0.3)
            }
            
            VStack {
                ZStack {
                    Rectangle().frame(height: 160).foregroundColor(.clear)
                    
                    VStack {
                        ZStack {
                            Text("Do Not Disturb")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .bold()
                            HStack {
                                Spacer()
                                Button {
                                    router.popToRoot()
                                } label: {
                                    Image("ExitButton")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.trailing, 30)
                                }
                            }
                        }
                        .padding(.top, 50)
                        
                        Text(data.isTimeOver ? "이제 밤정리 후 사진을 찍을 수 있어요 📸" : "지금은 밤정리 중 🌙")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                
                Group {
                    Spacer()
                    Spacer()
                    
                    VStack(spacing:-15){
                        ZStack() {
                            Text("\(timeStringMinutes(time: TimeInterval(data.currentSec)))")
                                .font(Font(UIFont.systemFont(ofSize: 72, weight: .semibold, width: .compressed)))
                            HStack {
                                Spacer(minLength: 250)
                                Text("min")
                                    .font(Font(UIFont.systemFont(ofSize: 24, weight: .semibold, width: .compressed)))
                                    .foregroundColor(.gray)
                                    .padding(.top)
                                Spacer()
                            }
                        }
                        ZStack() {
                            Text("\(timeStringSeconds(time: TimeInterval(data.currentSec)))")
                                .font(Font(UIFont.systemFont(ofSize: 72, weight: .semibold, width: .compressed)))
                            HStack {
                                Spacer(minLength: 250)
                                Text("sec")
                                    .font(Font(UIFont.systemFont(ofSize: 24, weight: .semibold, width: .compressed)))
                                    .foregroundColor(.gray)
                                    .padding(.top)
                                Spacer()
                            }
                        }
                    }
                    .foregroundColor(Color.white)


                    Spacer()
                    Spacer()

                    Button {
                        if (data.isMusicOn) {
                            data.pauseMusic()
                        } else {
                            data.playMusic()
                        }
                    } label: {
                        Image(data.isMusicOn ? "Play" : "Pause")
                            .resizable()
                            .frame(width: 54, height: 54)
                    }

                    Spacer()
                }
                
                ZStack {
                    Rectangle().frame(height: 160).foregroundColor(.clear)
                    
                    Button {
                        router.push(.B)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 56)
                                .foregroundColor(data.isTimeOver ? Color(hex: "5E5CE6") : Color.gray)
                                .padding()
                            Text("애프터 사진 찍으러 가기")
                                .foregroundColor(data.isTimeOver ? Color.white : Color.white.opacity(0.5))
                                .font(.system(size: 20))
                                .bold()
                        }
                    }
                    .disabled(!data.isTimeOver)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear() {
            data.beforeImage = viewModel.recentImage // 사진을 찍은 직후나, DoNotDisturbView가 OnAppear됐을떄는 recentImage가 nil이다. 아마 비동기적 처리 문제 때문일듯?
        }
    }
    
    func timeStringMinutes(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        return String(format: "%02i", minutes)
    }

    func timeStringSeconds(time: TimeInterval) -> String {
        let seconds = Int(time) % 60
        return String(format: "%02i", seconds)
    }
}
