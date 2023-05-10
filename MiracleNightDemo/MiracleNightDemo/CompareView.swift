//
//  CompareView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/09.
//

import SwiftUI

struct CompareView: View {
    @EnvironmentObject var dataModel: DataModel
    
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
                            if let lastData = dataModel.loadData().last, let beforeImage = dataModel.convertToUIImage(from: lastData.before) {
                                Image(uiImage: beforeImage)
                                    .resizable()
                                    .frame(width: 400, height: 200)
                                    .scaledToFill()
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
                            if let lastData = dataModel.loadData().last, let afterImage = dataModel.convertToUIImage(from: lastData.after) {
                                Image(uiImage: afterImage)
                                    .resizable()
                                    .frame(width: 400, height: 200)
                                    .scaledToFill()
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
            dataModel.showCompareView = false
        }
    }
}
