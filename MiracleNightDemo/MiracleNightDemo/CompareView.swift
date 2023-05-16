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
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        ZStack {
            FrameView()
            ImageView()
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
}

struct FrameView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        VStack {
            ZStack {
                Text("Record")
                    .font(.system(size: 24))
                    .bold()
                HStack {
                    Spacer()
                    Button {
                        router.pop(to: .B)
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .frame(width: 13, height: 15)
                            .foregroundColor(.white)
                        Text("다시 찍기")
                        Spacer()
                    }
                }
                .frame(height: 160)
                .foregroundColor(.white)
            }

            Spacer(minLength: 500)

            HStack {
                Button {
                    router.popToRoot()
                    
                    if (!data.isSavedImage) {
                        let _ = data.afterImage = viewModel.recentImage
                        let _ = data.saveDataToUserDefaults()
                        let _ = data.isSavedImage = true
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 358, height: 56)
                            .foregroundColor(Color(hex: "5E5CE6"))
                            .padding()
                        Text("저장하기")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
            .frame(height: 160)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    
    var body: some View {
        VStack {
            ZStack {
                let imageData = data.beforeImage?.pngData()
                if let image = data.convertToUIImage(from: imageData!) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 390, height: 292)
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
                let imageData = viewModel.recentImage?.pngData()
                if let image = data.convertToUIImage(from: imageData!) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 390, height: 292)
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
