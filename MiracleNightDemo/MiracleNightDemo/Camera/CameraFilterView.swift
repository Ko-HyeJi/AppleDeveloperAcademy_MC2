//
//  CameraFilterView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/04.
//

import SwiftUI

struct CameraFilterView: View {
    let msgArr = ["당신은\n나사르 왕국의 전사에게\n죽었습니다", "육각형 그리기는", "잘 모르겠네요...", "다시\n공부하도록\n하겠습니다", "잘 되나요?"]
    @State var currentMsgIdx = 0
    @State var timer: Timer?
    
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(.orange, lineWidth: 5)
                .frame(width: 300, height: 300)
            Text(msgArr[currentMsgIdx])
                .rotationEffect(.init(degrees: 90))
                .fontWeight(.bold)
                .foregroundColor(Color.orange)
                .multilineTextAlignment(.center)
                .onAppear {
                    // `Timer`를 시작
                    self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
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
}

struct CameraFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFilterView()
    }
}
