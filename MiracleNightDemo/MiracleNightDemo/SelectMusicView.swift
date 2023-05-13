//
//  SelectMusicView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/13.
//

import SwiftUI
import AVFoundation


struct SelectMusicView: View {
    @EnvironmentObject var data: DataModel
    @Binding var bottomSheetOn: Bool
        
    var body: some View {
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
                    .padding(.top, 20)
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
                            data.isMusicOn.toggle()
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
        }
    }
}

//struct SelectMusicView_Previews: PreviewProvider {
//    @Binding var bottomSheetOn: Bool
//    static var previews: some View {
//        SelectMusicView(bottomSheetOn: $bottomSheetOn)
//    }
//}
