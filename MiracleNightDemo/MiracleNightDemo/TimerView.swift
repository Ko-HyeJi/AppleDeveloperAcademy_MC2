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
        Circle().stroke(lineWidth: 15).frame(width: 170, height: 170).foregroundColor(Color(hex: "3F3F3F"))
    }
}

struct ProgressBar: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 170, height: 170)
            .overlay(
                Circle().trim(from: 0, to: progress())
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round,
                            lineJoin:.round
                        )
                )
                    .foregroundColor(
                        Color(hex: "5E5CE6")
                ).animation(
                    .easeInOut(duration: 0.2)
                ).rotationEffect(Angle(degrees: -90))
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
                if data.currentSec < data.timerSec {
                    ProgressBar(counter: counter, countTo: data.timerSec)
                }
                else {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 15))
                        .frame(width: 170, height: 170)
                        .foregroundColor(Color(hex: "5E5CE6"))
                }
                
                if !data.isTimeOver {
                    Image("Moon3").resizable().frame(width: 175, height: 175)
                    VStack(spacing: -20) {
                        Text("\(timeStringMinutes(time: TimeInterval(counter)))")
                            .font(Font(UIFont.systemFont(ofSize: 56, weight: .semibold, width: .compressed)))
                            .foregroundColor(.white)
                        Text("\(timeStringSeconds(time: TimeInterval(counter)))")
                            .font(Font(UIFont.systemFont(ofSize: 56, weight: .semibold, width: .compressed)))
                            .foregroundColor(.white)
                    }
                }
                else {
                    Image("Moon2").resizable().frame(width: 175, height: 175)
                    Image("Cross").resizable().frame(width: 40, height: 40)
                }
            }
        }
        .onAppear { counter = data.currentSec }
        .onReceive(timer) { time in
            if (self.counter < data.timerSec) {
                self.counter += 1
                if (counter == data.timerSec) {
                    data.isTimeOver = true
                    hapticFeedback(duration: 3, interval: 0.03)
                }
            }
        }
        .onDisappear {
            data.currentSec = counter
        }
    }
    
    func timeStringMinutes(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        return String(format: "%02i", minutes)
    }

    func timeStringSeconds(time: TimeInterval) -> String {
        let seconds = Int(time) % 60
        return String(format: "%02i", seconds)
    }

}
