//
//  DoNotDisturbView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/05.
//

import SwiftUI

struct DoNotDisturbView: View {
    @EnvironmentObject var dataModel: DataModel
    
    var body: some View {
        VStack {
            Text("Do Not Disturb")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            if let beforeImage = dataModel.beforeImage {
                Image(uiImage: beforeImage)
                    .resizable()
                    .rotationEffect(Angle(degrees: 270))
                    .frame(width: 300, height: 400)
            } else {
                Text("Did not take Before Image")
            }

            Spacer()
            
            HStack {
                Text("지금은 정리중입니다.")
                Spacer()
                Text("10:59") //타이머로 변경 필요
            }
                .font(.largeTitle)
                .padding()
            
            Button(action: {dataModel.isTimerOn = false}) {
                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
            }
        }
    }
}
