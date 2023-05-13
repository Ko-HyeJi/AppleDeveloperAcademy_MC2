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
            Color(hex: "48484A")
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
                        
                        Text("2023.05.06 정리를 완료했어요 🎉")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                
                Group {
                    Spacer()
                    SlideMaskView()
                    Spacer()
                }
                
                ZStack {
                    Rectangle().frame(height: 160).foregroundColor(.clear)
                }

            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SlideMaskView: View {
    @EnvironmentObject var data: DataModel
    @State private var maskOffset: CGSize = .zero
    @State private var maskSize: CGSize = .zero
    
    var body: some View {
        ZStack {
            if data.selectedIndex < data.dataArr.count {
                let specificData = data.dataArr[data.selectedIndex]
                if let beforeImage = data.convertToUIImage(from: specificData.before) {
                    Image(uiImage: beforeImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .clipped()
                }
            }
            
            Text("Before")
            .foregroundColor(Color.white)
            .background(Color.black .opacity(0.2))
            .padding(.top, 200)
            .padding(.leading, -180)
                
            
            if data.selectedIndex < data.dataArr.count {
                let specificData = data.dataArr[data.selectedIndex]
                if let afterImage = data.convertToUIImage(from: specificData.after) {
                    Image(uiImage: afterImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .clipped()
                        .mask(
                            Rectangle()
                                .frame(width: maskSize.width, height: maskSize.height)
                                .offset(y: maskOffset.height)
                        )
                    }
                }

            Text("After")
                .foregroundColor(Color.white)
                .background(Color.black .opacity(0.2))
                .padding(.bottom, 200)
                .padding(.leading, -180)
                .mask(
                    Rectangle()
                        .frame(width: maskSize.width, height: maskSize.height)
                        .offset(y: maskOffset.height))

            Image("SlideBar")
                .padding(.top, 230)
                .offset(y: maskOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let maxY = UIScreen.main.bounds.height / 3.7
                            if value.location.y < maxY && value.location.y > 0 {
                                maskOffset = value.translation
                            }
                        }
                        .onEnded { value in
                            maskOffset = .zero
                        }
                )
        }
        .onAppear { maskSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.7) }
    }
}

//
//struct SlideMaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        SlideMaskView()
//    }
//}
//
