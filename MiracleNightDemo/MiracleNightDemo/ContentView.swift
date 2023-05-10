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
//    @State var isBottomSheetOn = false
    @State var path: [Int] = []

    
    
    var body: some View {
        @State var countDay: Int = 2
        @State var currentGoal: Int = 7
        @State var progress: Double = Double(countDay) / Double(currentGoal)
        @State var progressText: String = "첫 방정리를 기다리고 있어요"
        
        NavigationStack(path: $path) {
            ZStack {
                Color(hex: "1C1C1E").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    if (data.username != nil) { //두번째 이후
                        Text(data.username! + "님 환영합니다!").font(.title).foregroundColor(.white)
                    } else { //처음 앱 사용할 때
                        Text(data.name + "님 환영합니다!").font(.title).foregroundColor(.white)
                    }

                    
                    if (!data.isDone){
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
                    
                    
                    NavigationLink(destination: CameraView(path: $path)) {
                        ZStack {
                            if (data.isTimerOn && !data.isDone) {
                                CountdownView()
                            } else {
                                Circle()
                                    .stroke(lineWidth: 3)
                                    .foregroundColor(.gray)
                                    .frame(width: 200, height: 200)
                            }
                            Image("Earth")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .opacity((data.isTimerOn && !data.isTimeOver) || data.isDone ? 0.1 : 1)
                        }
                    }
                    .disabled((data.isTimerOn && !data.isTimeOver) || data.isDone)
                    .simultaneousGesture(TapGesture().onEnded{
//                        path.append(1)
                    })
                    
                    Spacer()
                        
                    GeometryReader {
                        let size = $0.size

                        VStack(alignment: .center) {
                            Spacer()
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: size.width / 1.08, height: size.height / 6.16)
                                    .foregroundColor(Color (hex: "48484A"))
                                    .overlay {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("방정리 체크")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)
                                                    .padding(.vertical)

                                                Spacer()

                                                NavigationLink(destination: CheckProgressView().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                                                    Label {
                                                        Image(systemName: "chevron.right")
                                                                .foregroundColor(Color(hex: "757575"))
                                                            } icon: {
                                                                Text("more")
                                                                    .foregroundColor(.white)
                                                        }
                                                    .padding(.vertical)
                                                }
                                            }
                                            .padding(.top)

                                            Spacer()

                                            Text("\(countDay)/\(currentGoal)")
                                                .foregroundColor(Color.white)
                                                .fontWeight(.semibold)

                                            ProgressView("\(progressText)",value: progress)
                                                .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "9DEBBB")))
                                                .foregroundColor(.white)
                                                .padding(.bottom, size.height / 30)

                                            Spacer()
                                        }
                                        .padding(.vertical, size.height / 30 )
                                        .padding(.horizontal, size.width / 15)
                                    }
                        }
                        .padding()
                        .position(x: size.width / 2, y: size.height / 2)
                    }
                    
//                    NavigationLink(destination: TestView()) {
//                        Image(systemName: "photo.artframe")
//                            .resizable()
//                            .frame(width: 75, height: 75)
//                            .padding()
//                    }
                }
            }
        }
        .onAppear{
            if (data.username == nil) {
                data.isUnregistered = true
            }
        }
        .fullScreenCover(isPresented: $data.isUnregistered) {
            GetNameView()
        }
        .fullScreenCover(isPresented: $data.showCompareView) {
            CompareView()
        }
        .fullScreenCover(isPresented: $data.test) {
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
