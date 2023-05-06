//
//  BeforeAndAfterView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/06.
//

import SwiftUI

struct BeforeAndAfterView: View {
    @EnvironmentObject var dataModel: DataModel
    
    var body: some View {
        VStack {
            ZStack {
                if let bfImage = dataModel.beforeImage {
                    Image(uiImage: bfImage)
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
                if let afImage = dataModel.afterImage {
                    Image(uiImage: afImage)
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
            dataModel.isDone = false
        }
    }
}

//struct BeforeAndAfterView_Previews: PreviewProvider {
//    static var previews: some View {
//        BeforeAndAfterView()
//    }
//}
