//
//  ContentView.swift
//  VStackView
//
//  Created by 김규리 on 2023/05/08.
//

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

struct CustomColor {
    static let MainColor = Color("MainColor")
    // Add more here...
}


struct CompareView: View {
    
    
    var body: some View {
        
        ZStack {
            Color(hex: "#1C1C1E")
                .ignoresSafeArea(.all)
            
            
            ZStack {
//
//                RoundedRectangle(cornerRadius: 25, style: .continuous)
//                    .frame(height: 600)
//                    .foregroundColor(CustomColor.MainColor)

                
                VStack (spacing: 30) {
                    
                    
                    Text("정리 전후 사진을 저장합니다")
                        .font(.title2 .bold())
                    //                    .padding(.top, 130)
                        .foregroundColor(.white)
                    //  Text("Before")
                    
                    
                    VStack (spacing: 30) {
                        
                        ZStack {
                            ZStack {
                                
                            
                            Rectangle()//비포이미지자리
                                .foregroundColor(Color.pink)
                                .frame(width: 400, height: 200)
                                
                                Rectangle()//이미지 위 블러
                                    .foregroundColor(Color.black)
                                    .frame(width: 400, height: 200)
                                    .opacity(0.3)
                            }
                            
                            
                            Text("BEFORE")
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .padding(.top, 150)
                                .opacity(0.8)
                         
                        }
                        
                        
                        ZStack {
                            
                            ZStack {
                                Rectangle()//애프터이미지자리
                                    .foregroundColor(Color.pink)
                                    .frame(width: 400, height: 200)
                                
                                Rectangle()//이미지 위 블러
                                    .foregroundColor(Color.black)
                                    .frame(width: 400, height: 200)
                                    .opacity(0.3)
                                
                            }
                            
                            Text("AFTER")
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .padding(.top, 150)
                                .opacity(0.8)
                                
                                
                            
                        }
                        
//                        Button(action: {print("Button0")}){
//                            Text("확인")
//
//
//                        }
                        
                        
                    }
                    
                    
                    
                }
                .padding()
                
            }
            
            
            
            .padding()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CompareView()
    }
}
