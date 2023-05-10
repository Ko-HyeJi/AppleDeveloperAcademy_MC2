//
//  BeforeAndAfterView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/06.
//

import SwiftUI

struct BeforeAndAfterView: View {
    @EnvironmentObject var data: DataModel
    
    
    var body: some View {
        VStack {
            ZStack {
                if let lastData = data.loadData().last, let beforeImage = data.convertToUIImage(from: lastData.before) {
                    Image(uiImage: beforeImage)
                        .resizable()
                        .rotationEffect(Angle(degrees: 270))
                        .frame(width: 300, height: 400)
                        .scaledToFill()
                }
                Text("Before")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .bold()
            }
            ZStack {
                if let lastData = data.loadData().last, let afterImage = data.convertToUIImage(from: lastData.after) {
                    Image(uiImage: afterImage)
                        .resizable()
                        .rotationEffect(Angle(degrees: 270))
                        .frame(width: 300, height: 400)
                        .scaledToFill()
                }
                Text("After")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .bold()
            }
        }
        .onTapGesture {
            data.isDone = false
        }
    }
}

//struct BeforeAndAfterView_Previews: PreviewProvider {
//    static var previews: some View {
//        BeforeAndAfterView()
//    }
//}
