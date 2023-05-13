//
//  SelectMusicView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/13.
//

import SwiftUI
import AVFoundation


struct SelectMusicView: View {
    @State var playMusic = false
    @State private var audioPlayer: AVAudioPlayer?
    @Binding var bottomSheetOn: Bool
        
    var body: some View {
        if (playMusic) {
            playSound(filename: "music")
        } else {
            pauseSound()
        }
        ZStack {
            Color(hex: "1C1C1E").edgesIgnoringSafeArea(.all)
            VStack {
                Group {
                    HStack {
                        Text("음악을 추가해보세요.")
                            .font(.system(size: 20))
                            .bold()
                            .padding(.leading, 15)
                        Spacer()
                        Button {
                          bottomSheetOn = false
                        } label: { Image("ExitButton")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 15)
                        }
                    }
                    HStack {
                        Text("음악과 함께하면 정리정돈이 더 즐거워져요 🎧")
                            .font(.system(size: 14))
                            .padding(.leading, 15)
                        Spacer()
                    }
                    Divider()
                        .background(Color.white)
                        .padding([.top, .bottom], 15)
                }
                
                HStack {
                    //반복문 사용해서 코드 줄이기
                    Group {
                        Button {
                            //action
                        } label: {
                            Image("AppleMusic")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        Button {
                            //action
                        } label: {
                            Image("Melon")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        Button {
                            //action
                        } label: {
                            Image("Spotify")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                    }.padding(.trailing, 20)
                }.frame(width: 360, alignment: .leading)
                
                Spacer()
            }
            .foregroundColor(.white)
            
            
//            VStack {
//                Text("몰입감을 높여주는 음악을 추가해보세요.").font(.title2).foregroundColor(.white)
//                Text("음악과 함께하면 집중도가 높아져요!").foregroundColor(.white).padding()
//
//                ZStack {
//                    Rectangle()
//                        .cornerRadius(20)
//                        .foregroundColor(Color(hex: "1C1C1E"))
//                        .frame(width: 350, height: 100)
//                    HStack {
//                        Spacer()
//                        Image("AppleMusic").resizable().frame(width: 60, height: 60)
//                        Text("Apple Music").foregroundColor(.white)
//                        Spacer()
//                        Button {
//                            playMusic.toggle()
//                        } label: {
//                            Image("PlayButton").resizable().frame(width: 66, height: 28)
//                        }
//                        Spacer()
//                    }
//                }
//            }
        }
    }
    
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

}

//struct SelectMusicView_Previews: PreviewProvider {
//    @Binding var bottomSheetOn: Bool
//    static var previews: some View {
//        SelectMusicView(bottomSheetOn: $bottomSheetOn)
//    }
//}
