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
                        let dataArr = data.loadData()
                        ZStack {
//                            if let lastData = data.loadData().last, let beforeImage = data.convertToUIImage(from: lastData.before) {
//                            let dataArr = data.loadData()
                            if data.selectedIndex < dataArr.count {
                                let specificData = dataArr[data.selectedIndex] // 특정 인덱스의 요소를 가져옴

                                if let beforeImage = data.convertToUIImage(from: specificData.before) {
                                    Image(uiImage: beforeImage)
                                        .resizable()
                                        .frame(width: 400, height: 200)
                                        .scaledToFill()
                                }
                            }
//                            Image(uiImage: data.beforeImage!)
//                                .resizable()
//                                .frame(width: 400, height: 200)
//                                .scaledToFill()
////                            }
                            Rectangle()//이미지 위 블러
                                .foregroundColor(Color.black)
                                .frame(width: 400, height: 200)
                                .opacity(0.3)
                            Text("BEFORE")
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .padding(.top, 150)
                                .opacity(0.8)
                        }
                        ZStack {
//                            if let lastData = data.loadData().last, let afterImage = data.convertToUIImage(from: lastData.after) {
//                            Image(uiImage: viewModel.recentImage!)
//                                .resizable()
//                                .frame(width: 400, height: 200)
//                                .scaledToFill()
////                            }
                            if data.selectedIndex < dataArr.count {
                                let specificData = dataArr[data.selectedIndex] // 특정 인덱스의 요소를 가져옴

                                if let afterImage = data.convertToUIImage(from: specificData.after) {
                                    Image(uiImage: afterImage)
                                        .resizable()
                                        .frame(width: 400, height: 200)
                                        .scaledToFill()
                                }
                            }

                            Rectangle()//이미지 위 블러
                                .foregroundColor(Color.black)
                                .frame(width: 400, height: 200)
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
            data.test = false
        }
        .onDisappear {
            if (!data.isSaved) {
                let _ = data.afterImage = viewModel.recentImage
                let _ = data.saveDataToUserDefaults()
                let _ = data.isSaved = true
            }
        }
    }
}
