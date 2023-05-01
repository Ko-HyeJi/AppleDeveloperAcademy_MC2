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
            Spacer()
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
            
            Spacer()
            BottomSheetView(isBottomSheetOn: $isBottomSheetOn)
        }
    }
}

struct RotatingMessagesView: View {
    let msgArr = ["Message 1", "Message 2", "Message 3", "Message 4", "Message 5"]
    @State var currentMsgIdx = 0
    @State var timer: Timer?
    
    var body: some View {
        Text(msgArr[currentMsgIdx])
            .font(.body)
            .onAppear {
                // `Timer`를 시작
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    self.currentMsgIdx = (self.currentMsgIdx + 1) % self.msgArr.count
                }
            }
            .onDisappear {
                // `Timer`를 종료
                self.timer?.invalidate()
                self.timer = nil
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
