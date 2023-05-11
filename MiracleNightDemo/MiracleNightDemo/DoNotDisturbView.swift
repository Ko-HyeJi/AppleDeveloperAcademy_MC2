//
//  DoNotDisturbView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/05.
//

import SwiftUI

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
                    .opacity(0.7)
                    .background(Color(.black))
            } else {
//                Text("Did not take Before Image")
            }
            
            VStack {
                HStack { //상단 좌우 버튼
                    Button {
                        router.pop(to: .B)
                    } label: {
                        Image("BackButton")
                            .resizable()
                            .frame(width: 84, height: 22)
                    }.padding(.leading)

                    Spacer()

                    Button {
                        router.popToRoot()
                    } label: {
                        Image("CloseButton")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }.padding(.trailing)
                }
                .padding()
                
                VStack{
                    Spacer()
                    Text("Do Not Disturb")
                        .font(.title .bold())
                        .padding(1)
                    Text(isButtonEnabled ? "이제 밤정리 후 사진을 찍을 수 있어요📸" : "지금은 밤정리 중🌙")
                }
                .padding()
                VStack {
                    VStack {
                        Text("\(timeStringMinutes(time: TimeInterval(timerSeconds)))")
                            .font(.largeTitle .bold())
                            .scaleEffect(y:1.1)
                        Text("\(timeStringSeconds(time: TimeInterval(timerSeconds)))")
                            .font(.largeTitle .bold())
                            .scaleEffect(y:1.1)
                    }
                    .foregroundColor(Color.white)
                    Spacer()
                    Button("애프터 사진 찍으러 가기", action: buttonAction)
                        .foregroundColor(isButtonEnabled ? Color.white : Color.white.opacity(0.5))
                        .disabled(!isButtonEnabled) // 버튼 비활성화 상태를 상태 변수로 연결
                        .padding()
                        .frame(width: 300)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isButtonEnabled ? Color(red: 0x5E/255, green: 0x5C/255, blue: 0xE6/255) : Color.gray)
                        )
                        .padding(50)
                }
                
                
            }
            .foregroundColor(Color.white)
            .onReceive(timer) { _ in
                timerSeconds += 1
                if timerSeconds >= data.countTo { // 15분=900초 (60초 * 15분)
                    isButtonEnabled = true // 15분이 넘으면 버튼 활성화
                    data.isTimeOver = true
                }
            }
        }
        .onAppear {
            data.counter = 0
            data.isTimerOn = true
        }
        .onDisappear() {
            data.beforeImage = viewModel.recentImage // 사진을 찍은 직후나, DoNotDisturbView가 OnAppear됐을떄는 recentImage가 nil이다. 아마 비동기적 처리 문제 때문일듯?
            data.counter = timerSeconds
        }
        .navigationBarBackButtonHidden(true)
    }
        
    func timeStringMinutes(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        return String(format: "%02i", minutes)
    }
    
    func timeStringSeconds(time: TimeInterval) -> String {
        let seconds = Int(time) % 60
        return String(format: "%02i", seconds)
    }
    
    func buttonAction() {
        router.pop(to: .B)
    }
}
