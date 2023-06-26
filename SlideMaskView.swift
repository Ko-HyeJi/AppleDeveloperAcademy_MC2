//
//  SlideMaskView.swift
//  제발돼라...
//
//  Created by 김규리 on 2023/05/11.
//
// 주석추가~
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff
        )
    }
}

struct SlideMaskView: View {
    @State private var maskOffset: CGSize = .zero
    @State private var maskSize: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            Color(hex: "#1C1C1E")
                .ignoresSafeArea(.all)
            
            VStack (spacing:20){//타이틀 위로 올리기 위함
                VStack(spacing:20) {
                    Text("BEFORE & AFTER")
                        .foregroundColor(Color.white)
                        .font(.title2.bold())
                    
                    Text("2023.05.06 정리를 완료했어요 🎉")
                        .foregroundColor(Color.white)
                }.padding(.top, 20)
                
                Spacer()
                
                ZStack {
                    
                    
                    Image("루피3")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .clipped()
                    
                    Image("Before")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .padding(.top, 200)
                        .padding(.leading, -180)
                    
                    
                    
                    Image("루피2")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .clipped()
                        .mask(
                            Rectangle()
                                .frame(width: maskSize.width, height: maskSize.height)
                                .offset(y: maskOffset.height)
                            
                        )
                    //                        .gesture(
                    //                            DragGesture()
                    //                                .onChanged { value in
                    //                                    let maxY = UIScreen.main.bounds.height / 3
                    //                                    if value.location.y < maxY && value.location.y > 0 {
                    //                                        maskOffset = value.translation
                    //                                    }
                    //                                }
                    //                                .onEnded { value in
                    //                                    maskOffset = .zero
                    //                                }
                    //                        )
                    //이미지의 제스쳐반응은 필요없으므로 삭제처리
                    
                    Image("After")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .padding(.bottom, 200)
                        .padding(.leading, -180)
                        .mask(
                            Rectangle()
                                .frame(width: maskSize.width, height: maskSize.height)
                                .offset(y: maskOffset.height))
                    
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 400, height: 10)
                        .padding(.top, 260)
                        .offset(y: maskOffset.height)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let maxY = UIScreen.main.bounds.height / 3.2
                                    if value.location.y < maxY && value.location.y > 0 {
                                        maskOffset = value.translation
                                    }
                                }
                                .onEnded { value in
                                    maskOffset = .zero
                                }
                        )//제스쳐가 불안정한 문제 발생, 움직임 범위설정 수정 필요
                }}
            .padding(.bottom, 200)
            .onAppear {
                maskSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3.2)
            }
        }
    }
}


struct SlideMaskView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMaskView()
    }
}

