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
                
                Button {
                    router.push(.B)
                } label: {
                    ButtonView()
                }
                .disabled((data.isTimerOn && !data.isTimeOver) || data.isDone)
                
                Spacer(minLength: 300)
            }
            
            ProgressBarView()
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct SettingButtonView: View {
    @EnvironmentObject var data: DataModel
    
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
                    .opacity(data.isTimerOn && !data.isDone ? 1 : 0)
            }
            
            Spacer()
            
            Button {
                // action
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
        if (data.username != nil) { //두번째 이후
            Text(data.username! + "님 환영합니다!").font(.system(size: 22)).foregroundColor(.white).bold()
        } else { //처음 앱 사용할 때
            Text(data.name + "님 환영합니다!").font(.system(size: 22)).foregroundColor(.white).bold()
        }

        
        if (!data.isDone){
            let msgArr = ["아래 버튼을 눌러 방정리를 시작해보세요!", "오늘 정리할 곳을 정하고", "당신의 방정리를 사진으로 남겨보세요"]
            RotatingMessagesView(msgArr: msgArr)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding()
        } else {
            let msgArr = ["내일 6PM에 다시 만나요!"]
            RotatingMessagesView(msgArr: msgArr)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct RotatingMessagesView: View {
    @EnvironmentObject var data: DataModel
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
    
    var body: some View {
        if (data.isDone) {
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

//
//struct SoundButtonView_Preview: PreviewProvider {
//    static var previews: some View {
//        SoundButtonView()
//    }
//}
