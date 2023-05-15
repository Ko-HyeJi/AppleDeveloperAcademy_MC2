//
//  CompareView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/09.
//

import SwiftUI

struct CompareView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    
    var body: some View {
        ZStack {
            Color(hex: "#1C1C1E").ignoresSafeArea(.all)
            ZStack {
                VStack (spacing: 30) {
                    Text("정리 전후 사진을 저장합니다")
                        .font(.title2 .bold())
                        .foregroundColor(.white)
                    VStack (spacing: 30) {
                        ZStack {
                            let imageData = data.beforeImage?.pngData()
                            if let image = data.convertToUIImage(from: imageData!) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 400, height: 300)
                            }
                            Rectangle()//이미지 위 블러
                                .foregroundColor(Color.black)
                                .frame(width: 400, height: 300)
                                .opacity(0.3)
                            Text("BEFORE")
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .padding(.top, 150)
                                .opacity(0.8)
                        }
                        ZStack {
                            let imageData = viewModel.recentImage?.pngData()
                            if let image = data.convertToUIImage(from: imageData!) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 400, height: 300)
                            }
                            Rectangle()//이미지 위 블러
                                .foregroundColor(Color.black)
                                .frame(width: 400, height: 300)
                                .opacity(0.3)
                            Text("AFTER")
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .padding(.top, 150)
                                .opacity(0.8)
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
        .onTapGesture {
            data.showCompareView = false

            if (!data.isSaved) {
                let _ = data.afterImage = viewModel.recentImage
                let _ = data.saveDataToUserDefaults()
                let _ = data.isSaved = true
            }

//            if (data.isSetNotification == false) {
//                SendNotification(notificationTime: data.notificationTime!) //일단 임시로 여기에 옮겨둠... 첫 번째 방정리를 끝낸 다음에 알림을 받는게 좋으니깐 전혀 틀린건 아닐지도..?
//                defaults.set(true, forKey: "isSetNotification")
//            }
        }
        .onDisappear {
//            if (!data.isSaved) {
//                let _ = data.afterImage = viewModel.recentImage
//                let _ = data.saveDataToUserDefaults()
//                let _ = data.isSaved = true
//            }
        }
    }
}
