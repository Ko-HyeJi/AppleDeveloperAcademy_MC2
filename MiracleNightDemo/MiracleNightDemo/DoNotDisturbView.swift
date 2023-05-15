//
//  DoNotDisturbView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/05.
//

import SwiftUI
import AVFoundation

struct DoNotDisturbView: View {
    @State private var timerSeconds = 0
    @State private var isButtonEnabled = false // 버튼 활성화 여부를 나타내는 상태 변수
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @EnvironmentObject var router: Router<Path>

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        ZStack {
            if let beforeImage = viewModel.recentImage {
                Image(uiImage: beforeImage)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.black)
                    .opacity(0.3)
            } else {
//                Text("Did not take Before Image")
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
                        
                        Text(isButtonEnabled ? "이제 밤정리 후 사진을 찍을 수 있어요 📸" : "지금은 밤정리 중 🌙")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                
                Group {
                    Spacer()
                    Spacer()
                    
                    VStack(spacing:-15){
                        Text("\(timeStringMinutes(time: TimeInterval(timerSeconds)))")
                            .font(Font(UIFont.systemFont(ofSize: 72, weight: .semibold, width: .compressed)))
                        Text("\(timeStringSeconds(time: TimeInterval(timerSeconds)))")
                            .font(Font(UIFont.systemFont(ofSize: 72, weight: .semibold, width: .compressed)))
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
                        router.pop(to: .B)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 56)
                                .foregroundColor(isButtonEnabled ? Color(hex: "5E5CE6") : Color.gray)
                                .padding()
                            Text("애프터 사진 찍으러 가기")
                                .foregroundColor(isButtonEnabled ? Color.white : Color.white.opacity(0.5))
                                .font(.system(size: 20))
                                .bold()
                        }
                    }.disabled(!isButtonEnabled)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onReceive(timer) { _ in
                timerSeconds += 1
                if timerSeconds >= data.countTo { // 15분=900초 (60초 * 15분)
                    isButtonEnabled = true // 15분이 넘으면 버튼 활성화
                    data.isTimeOver = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            data.counter = 0
            data.isTimerOn = true
        }
        .onDisappear() {
            data.beforeImage = viewModel.recentImage // 사진을 찍은 직후나, DoNotDisturbView가 OnAppear됐을떄는 recentImage가 nil이다. 아마 비동기적 처리 문제 때문일듯?
            data.counter = timerSeconds
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

//struct DoNotDisturbView_Preview: PreviewProvider {
//    static var previews: some View {
//        DoNotDisturbView()
//    }
//}
