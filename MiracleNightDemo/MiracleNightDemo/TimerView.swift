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
            .frame(width: 160, height: 160)
            .overlay(
                Circle().stroke(Color(hex: "3F3F3F"), lineWidth: 15)
        )
    }
}

struct ProgressBar: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 160, height: 160)
            .overlay(
                Circle().trim(from:0, to: progress())
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round,
                            lineJoin:.round
                        )
                )
                    .foregroundColor(
                        Color(hex: "5E5CE6")
//                        (completed() ? Color(hex: "5E5CE6") : Color.white)
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
    @EnvironmentObject var data: DataModel
    @State var counter: Int = 0

    var body: some View {
        VStack{
            ZStack{
                ProgressTrack()
                ProgressBar(counter: counter, countTo: data.countTo)
            }
        }
        .onAppear {
            counter = data.counter
        }
        .onReceive(timer) { time in
            if (self.counter < data.countTo) {
                self.counter += 1
                if (counter == data.countTo) {
                    data.isTimeOver = true
                }
            }
        }
    }
}
