//
//  TimerView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/04.
//

import SwiftUI

let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

struct ProgressTrack: View {
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 200, height: 200)
            .overlay(
                Circle().stroke(Color.gray, lineWidth: 20)
        )
    }
}

struct ProgressBar: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 200, height: 200)
            .overlay(
                Circle().trim(from:0, to: progress())
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round,
                            lineJoin:.round
                        )
                )
                    .foregroundColor(
                        (completed() ? Color.green : Color.white)
                ).animation(
                    .easeInOut(duration: 0.2)
                )
        )
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
}

struct CountdownView: View {
    @EnvironmentObject var dataModel: DataModel
    @State var counter: Int = 0
    
//    var countTo: Int = 5
    
    var body: some View {
        VStack{
            ZStack{
                ProgressTrack()
                ProgressBar(counter: counter, countTo: dataModel.countTo)
            }
        }
        .onAppear {
            counter = dataModel.counter
        }
        .onReceive(timer) { time in
            if (self.counter < dataModel.countTo) {
                self.counter += 1
                if (counter == dataModel.countTo) {
                    dataModel.isTimeOver = true
                }
            }
        }
    }
}

//struct CountdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountdownView()
//    }
//}
