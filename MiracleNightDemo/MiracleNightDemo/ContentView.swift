//
//  ContentView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
//    @State var isBottomSheetOn = false   
    
    
    var body: some View {
        NavigationStack() {
            ZStack {
                Color(hex: "1C1C1E").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    if (dataModel.username != nil) { //두번째 이후
                        Text(dataModel.username! + "님 환영합니다!").font(.title).foregroundColor(.white)
                    } else { //처음 앱 사용할 때
                        Text(dataModel.name + "님 환영합니다!").font(.title).foregroundColor(.white)
                    }

                    
                    if (!dataModel.isDone){
                        let msgArr = ["아래 버튼을 눌러 방정리를 시작해보세요!", "오늘 정리할 곳을 정하고", "당신의 방정리를 사진으로 남겨보세요"]
                        RotatingMessagesView(msgArr: msgArr)
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        let msgArr = ["오늘의 방정리가 끝났습니다.", "수고하셨습니다!"]
                        RotatingMessagesView(msgArr: msgArr)
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    
                    NavigationLink(destination: CameraView()) {
                        ZStack {
                            if (dataModel.isTimerOn && !dataModel.isDone) {
                                CountdownView()
                            } else {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 200, height: 200)
                                    .overlay(
                                        Circle().stroke(Color.gray, lineWidth: 3)
                                )
                            }
                            Image("Earth")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .opacity((dataModel.isTimerOn && !dataModel.isTimeOver) || dataModel.isDone ? 0.1 : 1)
                        }
                    }
                    .disabled((dataModel.isTimerOn && !dataModel.isTimeOver) || dataModel.isDone)
                    
                    Spacer()
                }
            }
        }
        .onAppear{
            if (dataModel.username == nil) {
                dataModel.isUnregistered = true
            }
        }
        .fullScreenCover(isPresented: $dataModel.isUnregistered) {
            GetNameView()
        }
        .fullScreenCover(isPresented: $dataModel.showCompareView) {
            // after 사진까지 찍고 나서 UserDefaults에 저장하는 과정! -> 비동기 처리 때문에 after 사진 찍은 직후에 CameraView에서 처리 불가능...
            let _ = dataModel.afterImage = viewModel.recentImage
            let _ = dataModel.saveDataToUserDefaults()
            
            CompareView()
        }
    }
}

struct RotatingMessagesView: View {
    @EnvironmentObject var dataModel: DataModel
    @State var currentMsgIdx = 0
    @State var timer: Timer?
    var msgArr: [String] = []
    
    var body: some View {
        HStack {
            Text("Tips")
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
