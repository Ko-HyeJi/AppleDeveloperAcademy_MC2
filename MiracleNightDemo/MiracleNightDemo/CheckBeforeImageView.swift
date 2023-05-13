//
//  CheckBeforeImageView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/13.
//

import SwiftUI

struct CheckBeforeImageView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @State private var bottomSheetOn = false
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        ZStack {
            Color(hex: "1C1C1E").edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    Rectangle().frame(height: 160).foregroundColor(.clear)
                    
                    HStack {
                        Spacer()
                        Button {
                            router.pop(to: .B)
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 17, height: 22)
                                .foregroundColor(.white)
                                .padding(.leading, 30)
                            Text("다시 찍기")
                            Spacer()
                        }
                    }
                    .padding(.top, 20)
                    .foregroundColor(.white)
                }
                
                Group {
                    Spacer()
                    
                    if let imageData = viewModel.recentImage?.pngData() {
                        let beforeImage = data.convertToUIImage(from: imageData)
                        Image(uiImage: beforeImage!)
                            .resizable()
                            .frame(width: 390, height: 285)
                            .padding()
                    } else {
        //                Text("Did not take Before Image")
                    }
                    
                    Button {
                        bottomSheetOn = true
                    } label: {
                        Image("MusicIcon")
                            .resizable()
                            .frame(width: 54, height: 54)
                    }
                    ZStack {
                        Image("SpeechBubble")
                            .resizable()
                            .frame(width: 225, height: 56)
                        Text("밤정리를 도와줄 음악을 추가해보세요")
                            .foregroundColor(.white)
                            .font(.system(size: 13)).padding(.top)
                    }

                    Spacer()
                }
                
                ZStack {
                    Rectangle().frame(height: 160).foregroundColor(.clear)
                    
                    Button {
                        router.push(.D)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 56)
                                .foregroundColor(Color(hex: "5E5CE6"))
                                .padding()
                            Text("밤정리 시작하기")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .bold()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $bottomSheetOn) {
            SelectMusicView(bottomSheetOn: $bottomSheetOn)
                .presentationDetents([.fraction(0.35), .large])
                .foregroundColor(.white)
        }
    }
}

//struct BottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
////        BottomSheetView()
//        CheckBeforeImageView()
//    }
//}
