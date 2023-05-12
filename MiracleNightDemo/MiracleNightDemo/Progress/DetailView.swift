//
//  SlideMaskView.swift
//  제발돼라...
//
//  Created by 김규리 on 2023/05/11.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var data: DataModel
    @State private var maskOffset: CGSize = .zero
    @State private var maskSize: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            Color(hex: "#1C1C1E")
                .ignoresSafeArea(.all)
            
            VStack (spacing:20) {
                Text("BEFORE & AFTER")
                    .foregroundColor(Color.white)
                    .font(.title2.bold())
                
                Text("슬라이더를 위로 움직여 비교해 보세요")
                    .foregroundColor(Color.white)
                
                
                
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
                
            }
            .onAppear { maskSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.7) }
        }
        .onTapGesture { data.showDetailView = false }
    }
}

//
//struct SlideMaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        SlideMaskView()
//    }
//}
//
