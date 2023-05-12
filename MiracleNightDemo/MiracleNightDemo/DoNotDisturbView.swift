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
    
    @State private var isBottomSheetOn = true
    
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
                
                VStack (spacing: -110){
                        VStack{
                            VStack{
                                Spacer()
                                Text("Do Not Disturb")
                                    .font(.title .bold())
                                    .padding(1)
                                Text(isButtonEnabled ? "이제 밤정리 후 사진을 찍을 수 있어요📸" : "지금은 밤정리 중🌙")
                            }
                            .padding(5)
                            VStack(spacing:-15){
                                Text("\(timeStringMinutes(time: TimeInterval(timerSeconds)))")
                                    .font(Font(UIFont.systemFont(ofSize: 72, weight: .semibold, width: .condensed)))
                                Text("\(timeStringSeconds(time: TimeInterval(timerSeconds)))")
                                    .font(Font(UIFont.systemFont(ofSize: 72, weight: .semibold, width: .condensed)))
                            }
                            .foregroundColor(Color.white)
                        }
                        
                        VStack {
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
        .sheet(isPresented: $isBottomSheetOn) {
            BottomSheetView()
                .presentationDetents([.fraction(0.4), .large])
                .foregroundColor(.white)
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
        router.pop(to: .B)
    }
}

struct BottomSheetView: View {
    @State var playMusic = false
    @State private var audioPlayer: AVAudioPlayer?
    
    func playSound(filename: String) -> some View {
        var audioPlayer: AVAudioPlayer?
        if let path = Bundle.main.path(forResource: filename, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
            } catch {
                //error handler
            }
        }
        return(Text("").onAppear{ audioPlayer?.play() })
    }

    func pauseSound() -> some View {
        return(Text("").onAppear{ audioPlayer?.pause() })
    }
    
    var body: some View {
        if (playMusic) {
            playSound(filename: "music")
        } else {
            pauseSound()
        }
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all).opacity(0.5)
            VStack {
                Text("몰입감을 높여주는 음악을 추가해보세요.").font(.title2).foregroundColor(.white)
                Text("음악과 함께하면 집중도가 높아져요!").foregroundColor(.white).padding()
                
                ZStack {
                    Rectangle()
                        .cornerRadius(20)
                        .foregroundColor(Color(hex: "1C1C1E"))
                        .frame(width: 350, height: 100)
                    HStack {
                        Spacer()
                        Image("AppleMusic").resizable().frame(width: 60, height: 60)
                        Text("Apple Music").foregroundColor(.white)
                        Spacer()
                        Button {
                            playMusic.toggle()
                        } label: {
                            Image("PlayButton").resizable().frame(width: 66, height: 28)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView()
    }
}
