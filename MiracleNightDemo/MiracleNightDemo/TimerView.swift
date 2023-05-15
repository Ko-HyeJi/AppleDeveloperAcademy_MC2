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
        Circle().stroke(lineWidth: 10).frame(width: 115, height: 115).foregroundColor(Color(hex: "3F3F3F"))
    }
}

struct ProgressBar: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 115, height: 115)
            .overlay(
                Circle().trim(from: 0, to: progress())
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round,
                            lineJoin:.round
                        )
                )
                    .foregroundColor(
                        Color(hex: "5E5CE6")
                ).animation(
                    .easeInOut(duration: 0.2)
                )
        )
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
        .onAppear { counter = data.counter }
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
