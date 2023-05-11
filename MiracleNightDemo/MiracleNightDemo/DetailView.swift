//
//  DetailView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/09.
//

import SwiftUI

struct DetailView: View {
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
//                        let dataArr = data.loadData()
                        ZStack {
                            if data.selectedIndex < data.dataArr.count {
                                let specificData = data.dataArr[data.selectedIndex] // 특정 인덱스의 요소를 가져옴

                                if let beforeImage = data.convertToUIImage(from: specificData.before) {
                                    Image(uiImage: beforeImage)
                                        .resizable()
                                        .frame(width: 400, height: 200)
                                        .scaledToFill()
                                }
                            }
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
                            if data.selectedIndex < data.dataArr.count {
                                let specificData = data.dataArr[data.selectedIndex] // 특정 인덱스의 요소를 가져옴

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
            data.showDetailView = false
        }
    }
}
