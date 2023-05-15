//
//  SelectMusicView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/13.
//

import SwiftUI
import AVFoundation

struct SelectMusicView: View {
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
                        .background(Color(hex: "545458"))
                        .padding([.top, .bottom], 15)
                }
                
                MusicAppView(bottomSheetOn: $bottomSheetOn)
                
                Spacer()
            }
            .foregroundColor(.white)
        }
    }
}

struct MusicAppView: View {
    @EnvironmentObject var data: DataModel
    @Binding var bottomSheetOn: Bool
    
    let musicApps: [MusicApp] = [
        MusicApp(appIcon: "AppleMusic", appURL: "music://", appStoreURL: "apple-music/id1108187390"),
        MusicApp(appIcon: "Melon", appURL: "melon://", appStoreURL: "%EB%A9%9C%EB%A1%A0-melon/id415597317"),
        MusicApp(appIcon: "Spotify", appURL: "spotify://", appStoreURL: "spotify-%EC%8A%A4%ED%8F%AC%ED%8B%B0%ED%8C%8C%EC%9D%B4-%EB%AE%A4%EC%A7%81-%ED%8C%9F%EC%BA%90%EC%8A%A4%ED%8A%B8-%EC%95%B1/id324684580")]
    
    var body: some View {
        HStack {
            ForEach(musicApps, id: \.self.appIcon) { app in
                Button {
                    if let appURL = URL(string: app.appURL) {
                        if UIApplication.shared.canOpenURL(appURL) {
                            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                        } else {
                            if let appStoreURL = URL(string: ("https://apps.apple.com/kr/app/" + app.appStoreURL)) {
                                UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                            }
                        }
                    }
                    bottomSheetOn = false
                } label: {
                    Image(app.appIcon)
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }.padding(.trailing, 20)
            
            Button {
                if (data.isMusicOn) {
                    data.pauseMusic()
                } else {
                    data.playMusic()
                }
                bottomSheetOn = false
            } label: {
                Image("Music")
                    .resizable()
                    .frame(width: 60, height: 60)
            }.padding(.trailing, 20)
            
        }.frame(width: 360, alignment: .leading)
    }
}

struct MusicApp {
    let appIcon: String
    let appURL: String
    let appStoreURL: String
}

