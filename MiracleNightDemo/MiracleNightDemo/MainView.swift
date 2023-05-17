//
//  MainView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/12.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var router: Router<Path>
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        ZStack {
            Color(hex: "1C1C1E").edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                SettingButtonView()
                MessageView()
                
                Spacer(minLength: 120)
                
                ZStack {
                    Button {
                        hapticFeedback(duration: 0.2, interval: 0.05)
                        router.push(.B)
                    } label: {
                        ButtonView()
                    }
                    .disabled((data.isTimerOn && !data.isTimeOver) || data.isSavedImage)
                    
                    Button { //DoNotDisturb뷰로 돌아가는 버튼
                        router.push(.D)
                    } label: {
                        Image("")
                            .frame(width: 150, height: 150)
                            .foregroundColor(.clear)
                    }.opacity(data.isTimerOn && !data.isTimeOver ? 1 : 0)
                }

                Spacer(minLength: 300)
            }
            
            ProgressBarView()
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct SettingButtonView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        HStack {
            Button {
                if (data.isMusicOn) {
                    data.pauseMusic()
                } else {
                    data.playMusic()
                }
            } label: {
                Image(data.isMusicOn ? "Play_w" : "Pause_w")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .opacity(data.isTimerOn && !data.isSavedImage ? 1 : 0)
            }
            
            Spacer()
            
            Button {
                router.push(.F)
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
        }
    }
}

struct MessageView: View {
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        if (!data.isTimerOn){
            Text("좋은 저녁이에요 " + data.userName + "!").font(.system(size: 28)).foregroundColor(.white).bold()
            let msgArr = ["아래 버튼을 눌러 밤정리를 시작해보세요!", "밤정리 \(calcCurrentGoal())회 목표를 달성해보세요!", "처음에는 가볍게 5분동안 밤정리"]
            RotatingMessagesView(msgArr: msgArr)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
        } else if (!data.isSavedImage) {
            Text("Do not disturb").font(.system(size: 28)).foregroundColor(.white).bold()
            let msgArr = ["지금은 정리 중..."]
            RotatingMessagesView(msgArr: msgArr)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
        }
        else {
            Text("오늘의 밤정리는 여기까지").font(.system(size: 28)).foregroundColor(.white).bold()
            let msgArr = ["내일 6PM에 다시 만나요!"]
            RotatingMessagesView(msgArr: msgArr)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
        }
    }
    
    func calcCurrentGoal() -> Int {
        if data.dataArr.count < 3 {
            return 3
        } else if data.dataArr.count < 8 {
            return 5
        } else {
            return 7
        }
    }
}

struct RotatingMessagesView: View {
    @State var currentMsgIdx = 0
    @State var timer: Timer?
    var msgArr: [String] = []
    
    var body: some View {
        HStack {
            Text(msgArr[currentMsgIdx])
                .font(.body)
                .onAppear {
                    // `Timer`를 시작
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
                        self.currentMsgIdx = (self.currentMsgIdx + 1) % self.msgArr.count
                    }
                }
                .onDisappear {
                    // `Timer`를 종료
                    self.timer?.invalidate()
                    self.timer = nil
                }
        }
    }
}

struct ButtonView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        if (data.isSavedImage) {
            ZStack {
                Circle().stroke(lineWidth: 15).frame(width: 170, height: 170).foregroundColor(Color(hex: "6E6E6E"))
                Image("Moon1").resizable().frame(width: 175, height: 175)
                VStack(spacing: -10) {
                    Text("See you")
                        .font(Font(UIFont.systemFont(ofSize: 40, weight: .semibold, width: .compressed)))
                        .foregroundColor(Color(hex: "757575"))
                    Text("tomorrow")
                        .font(Font(UIFont.systemFont(ofSize: 40, weight: .semibold, width: .compressed)))
                        .foregroundColor(Color(hex: "757575"))
                }
            }
        } else if (data.isTimerOn) {
            CountdownView()
        } else {
            ZStack {
                Circle().stroke(lineWidth: 15).frame(width: 170, height: 170).foregroundColor(Color(hex: "3F3F3F"))
                Image("Moon2").resizable().frame(width: 175, height: 175)
                Image("Cross").resizable().frame(width: 40, height: 40)
            }
        }
    }
}
