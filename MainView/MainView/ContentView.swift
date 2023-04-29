//
//  ContentView.swift
//  MainView
//
//  Created by 고혜지 on 2023/04/30.
//

import SwiftUI

struct ContentView: View {
    @State var isBottomSheetOn = false
    var body: some View {
        NavigationStack {
            RotatingMessagesView()
                .padding()
            
            HStack {
                Image(systemName: "hand.tap.fill")
                Text("터치하여 방정리하기")
            }
            
            NavigationLink(destination: CameraView()) {
                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 80, height: 60)
            }
            
            BottomSheetView(isBottomSheetOn: $isBottomSheetOn)
        }
    }
}


struct RotatingMessagesView: View {
    let msgArr = ["Message 1", "Message 2", "Message 3", "Message 4", "Message 5",]
    @State var currentMsgIdx = 0
    
    var body: some View {
        Text(msgArr[currentMsgIdx])
            .font(.body)
            .onAppear {
            // 타이머 시작
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                // 현재 메세지 인덱스를 업데이트하고 뷰를 다시 그림
                currentMsgIdx = (currentMsgIdx + 1) % msgArr.count
            }
        }
    }
}

struct CameraView: View {
    var body: some View {
        Text("It's Camera View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
