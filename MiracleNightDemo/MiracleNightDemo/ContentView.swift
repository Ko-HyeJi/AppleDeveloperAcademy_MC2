//
//  ContentView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel
    @State var isBottomSheetOn = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "1C1C1E").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    if (dataModel.username != nil) { //두번째 이후
                        Text(dataModel.username! + "님 환영합니다!").font(.title).foregroundColor(.white)
                    } else { //처음 앱 사용할 때
                        Text(dataModel.name + "님 환영합니다!").font(.title).foregroundColor(.white)
                    }

                    //tmp
                    Text(String(dataModel.count) + "번 정리를 완료했습니다")
                    
                    RotatingMessagesView()
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("당신의 방정리를 기다리고 있습니다.\n\n아래 버튼을 눌러 방정리를 시작해보세요!\n\n오늘 정리할 곳을 직접 정해주세요")
                        .foregroundColor(.white)
                        .padding()
                    
                    NavigationLink(destination: CameraView().environmentObject(dataModel)) {
                        ZStack {
                            CountdownView()
                            Image("Bitmap")
                                .resizable()
                                .frame(width: 150, height: 150)
                            if (dataModel.beforeImage == nil) {
                                Text("Take BF Image").foregroundColor(.black).bold().foregroundColor(.white)
                            } else if (dataModel.afterImage == nil) {
                                Text("Take AF Image").foregroundColor(.black).bold().foregroundColor(.white)
                            } else {
                                Text("오늘의 방정리가 끝났습니다.").foregroundColor(.black).bold().foregroundColor(.white)
                            }
                        }
                    }.disabled(dataModel.beforeImage != nil && dataModel.afterImage != nil)
                    
                    Spacer()
                    BottomSheetView(isBottomSheetOn: $isBottomSheetOn)
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
        .fullScreenCover(isPresented: $dataModel.isTimerOn) {
            DoNotDisturbView()
        }
        .fullScreenCover(isPresented: $dataModel.isDone) {
            BeforeAndAfterView()
        }
        .fullScreenCover(isPresented: $dataModel.test) {
            TestView()
        }
    }
}

struct RotatingMessagesView: View {
    let msgArr = ["이곳은", "Tip 메시지가", "나오는", "자리입니다", "잘 나오나요?"]
    @State var currentMsgIdx = 0
    @State var timer: Timer?
    
    var body: some View {
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
