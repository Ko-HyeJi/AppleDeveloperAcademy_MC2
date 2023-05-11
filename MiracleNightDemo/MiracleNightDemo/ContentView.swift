//
//  ContentView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @ObservedObject var router = Router<Path>()
    
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @AppStorage("_isSecondLaunching") var isSecondLaunching: Bool = true
    
    var body: some View {
        NavigationStack(path: $router.paths) {
            MainView()
            .navigationDestination(for: Path.self) { path in
                switch path {
                case .A: MainView()
                case .B: CameraView()
                case .C: DoNotDisturbView()
                }
            }
        }
        .environmentObject(router)
        .onAppear{ data.dataArr = data.loadData() }
        .fullScreenCover(isPresented: $data.showCompareView) { CompareView() }
        .fullScreenCover(isPresented: $data.showDetailView) { DetailView() }
        .fullScreenCover(isPresented: $isFirstLaunching) { OnboardingTabView(isFirstLaunching: $isFirstLaunching) }
        .fullScreenCover(isPresented: $isSecondLaunching) { OnboardingNickNameView(isSecondLaunching: $isSecondLaunching) }
    }
}

struct MainView: View {
    @EnvironmentObject var router: Router<Path>
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        ZStack {
            Color(hex: "1C1C1E").edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                MessageView()
                Spacer()
                
                Button {
                    router.push(.B)
                } label: {
                    ButtonView()
                }
                .disabled((data.isTimerOn && !data.isTimeOver) || data.isDone)
                
                Spacer(minLength: 300)
            }
            
            ProgressBarView()
        }
    }
}


struct MessageView: View {
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        if (data.username != nil) { //두번째 이후
            Text(data.username! + "님 환영합니다!").font(.title2).foregroundColor(.white).bold()
        } else { //처음 앱 사용할 때
            Text(data.name + "님 환영합니다!").font(.title2).foregroundColor(.white).bold()
        }

        
        if (!data.isDone){
            let msgArr = ["아래 버튼을 눌러 방정리를 시작해보세요!", "오늘 정리할 곳을 정하고", "당신의 방정리를 사진으로 남겨보세요"]
            RotatingMessagesView(msgArr: msgArr)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
        } else {
            let msgArr = ["내일 6PM에 다시 만나요!"]
            RotatingMessagesView(msgArr: msgArr)
                .font(.title2)
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
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
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
                Circle().stroke(lineWidth: 15).frame(width: 160, height: 160).foregroundColor(Color(hex: "6E6E6E"))
                Image("Moon1").resizable().frame(width: 165, height: 165)
                Image("X").resizable().frame(width: 40, height: 40)
            }
        } else if (data.isTimerOn) {
            ZStack {
//                Circle().stroke(lineWidth: 15).frame(width: 160, height: 160).foregroundColor(Color(hex: "3F3F3F"))
                CountdownView()
                Image("Moon3").resizable().frame(width: 165, height: 165)
            }
        } else {
            ZStack {
                Circle().stroke(lineWidth: 15).frame(width: 160, height: 160).foregroundColor(Color(hex: "3F3F3F"))
                Image("Moon2").resizable().frame(width: 165, height: 165)
                Image("Cross").resizable().frame(width: 40, height: 40)
            }
        }
    }
}
