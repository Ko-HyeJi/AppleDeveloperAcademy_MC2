//
//  SlideMaskView.swift
//  제발돼라...
//
//  Created by 김규리 on 2023/05/11.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        
        ZStack {
            Color(hex: "282828")
                .ignoresSafeArea(.all)
            
            VStack (spacing:20) {
                ZStack {
                    Rectangle()
                        .frame(height: 160)
                        .foregroundColor(Color(hex: "1C1C1E"))

                    VStack {
                        ZStack {
                            Text("Before & After")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .bold()
                            HStack {
                                Button {
                                    data.showDetailView = false
                                } label: {
                                    Image(systemName: "chevron.backward")
                                        .resizable()
                                        .frame(width: 17, height: 22)
                                        .foregroundColor(.white)
                                        .padding(.leading, 30)
                                }
                                Spacer()
                            }
                        }
                        .padding(.top, 50)
                        
                        let dateFormatter = DateFormatter()
                        let _ = dateFormatter.dateFormat = "yyyy.MM.dd"
                        let date = data.dataArr[data.selectedIndex].date
                        Text("   " + dateFormatter.string(from: date) + " 정리를 완료했어요 🎉")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                
                ZStack {
                    if data.selectedIndex < data.dataArr.count {
                        let selectedData = data.dataArr[data.selectedIndex]
                        if let beforeImage = data.convertToUIImage(from: selectedData.before) {
                            Image(uiImage: beforeImage)
                                .resizable()
                                .frame(width: 390, height: 292)
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Before")
                                .font(.system(size: 15))
                                .frame(width: 56, height: 28)
                                .foregroundColor(Color.white)
                                .background(RoundedRectangle(cornerRadius: 15).fill(.black).opacity(0.5))
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(16)
                }
                .frame(width: 390, height: 292)

                ZStack {
                    if data.selectedIndex < data.dataArr.count {
                        let selectedData = data.dataArr[data.selectedIndex]
                        if let afterImage = data.convertToUIImage(from: selectedData.after) {
                            Image(uiImage: afterImage)
                                .resizable()
                                .frame(width: 390, height: 292)
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("After")
                                .font(.system(size: 15))
                                .frame(width: 56, height: 28)
                                .foregroundColor(Color.white)
                                .background(RoundedRectangle(cornerRadius: 15).fill(.black).opacity(0.5))
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(16)
                }
                .frame(width: 390, height: 292)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
