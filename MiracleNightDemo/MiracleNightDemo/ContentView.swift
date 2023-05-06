//
//  ContentView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel
    @State var isBottomSheetOn = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            
            if (dataModel.isUnregistered == false && dataModel.username != nil) { //두번째 이후
                VStack {
                    Text("Hello, " + dataModel.username!).font(.title)
                    let msg:String = String(dataModel.visited + 1) + "번째 방문입니다."
                    Text(msg)
                }
            } else { //처음 앱 사용할 때
                VStack {
                    Text("Hello, " + dataModel.name).font(.title)
                    let msg:String = String(dataModel.visited + 1) + "번째 방문입니다."
                    Text(msg)
                }
            }


            RotatingMessagesView()
                .font(.title2)
                .padding()
            
            HStack {
                Image(systemName: "hand.tap.fill")
                Text("터치하여 방정리하기")
            }
            
            NavigationLink(destination: CameraView().environmentObject(dataModel)) {
                ZStack {
                    CountdownView()
                    Image(systemName: "camera.fill")
                        .resizable()
                        .frame(width: 80, height: 60)
                    if (dataModel.beforeImage == nil) {
                        Text("Take BF Image").foregroundColor(.black).bold()
                    } else if (dataModel.afterImage == nil) {
                        Text("Take AF Image").foregroundColor(.black).bold()
                    } else {
                        Text("오늘의 방정리가 끝났습니다.").foregroundColor(.black).bold()
                    }
                }
            }.disabled(dataModel.beforeImage != nil && dataModel.afterImage != nil)
            
            Spacer()
            BottomSheetView(isBottomSheetOn: $isBottomSheetOn)
        }
    }
}

struct RotatingMessagesView: View {
    let msgArr = ["이곳은", "Tip 메시지가", "나오는", "자리입니다", "잘 나오나요?"]
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
