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
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @Environment(\.presentationMode) var presentationMode
    
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
                Text("Did not take Before Image")
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }.padding(.trailing)
                }
                VStack{
                    Spacer()
                    Text("Do Not Disturb")
                        .font(.title .bold())
                        .padding(1)
                    Text("지금은 방정리 중...")
                }
                .padding()
                VStack {
                    VStack {
                        Text("\(timeStringMinutes(time: TimeInterval(timerSeconds)))")
                            .font(.largeTitle .bold())
                        Text("\(timeStringSeconds(time: TimeInterval(timerSeconds)))")
                            .font(.largeTitle .bold())
                    }
                    .foregroundColor(isButtonEnabled ? Color.blue : Color.white)
                    Spacer()
                    Button("애프터 사진 찍으러 가기", action: buttonAction)
                        .disabled(!isButtonEnabled) // 버튼 비활성화 상태를 상태 변수로 연결
                        .padding()
                        .frame(width: 300)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(isButtonEnabled ? Color.blue : Color.gray)
                        )
                        .padding(50)
                }
                
                
            }
            .foregroundColor(Color.white)
            .onReceive(timer) { _ in
                timerSeconds += 1
                if timerSeconds >= dataModel.countTo { // 15분=900초 (60초 * 15분)
                    isButtonEnabled = true // 15분이 넘으면 버튼 활성화
                    dataModel.isTimeOver = true
                }
            }
        }
        .onAppear {
            dataModel.counter = 0
            dataModel.isTimerOn = true
        }
        .onDisappear() {
            dataModel.beforeImage = viewModel.recentImage // 사진을 찍은 직후나, DoNotDisturbView가 OnAppear됐을떄는 recentImage가 nil이다. 아마 비동기적 처리 문제 때문일듯?
            dataModel.counter = timerSeconds
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
    
    func buttonAction() {
        presentationMode.wrappedValue.dismiss()
    }
}

//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView()
//    }
//}
//
