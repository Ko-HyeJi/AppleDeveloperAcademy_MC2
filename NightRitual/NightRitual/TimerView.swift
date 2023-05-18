import SwiftUI

struct CountdownView: View {
    @EnvironmentObject var data: DataModel

    var body: some View {
        VStack{
            ZStack{
                ProgressTrack()
                if !data.isTimeOver {
                    ProgressBar(counter: data.currentSec, countTo: data.timerSec)
                    Image("Moon3").resizable().frame(width: 175, height: 175)
                    VStack(spacing: -20) {
                        Text("\(timeStringMinutes(time: TimeInterval(data.currentSec)))")
                            .font(Font(UIFont.systemFont(ofSize: 56, weight: .semibold, width: .compressed)))
                            .foregroundColor(.white)
                        Text("\(timeStringSeconds(time: TimeInterval(data.currentSec)))")
                            .font(Font(UIFont.systemFont(ofSize: 56, weight: .semibold, width: .compressed)))
                            .foregroundColor(.white)
                    }
                }
                else {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 15))
                        .frame(width: 170, height: 170)
                        .foregroundColor(Color(hex: "5E5CE6"))
                    Image("Moon2").resizable().frame(width: 175, height: 175)
                    Image("Cross").resizable().frame(width: 40, height: 40)
                }
            }
        }
        .onReceive(data.timer) { time in
            if (data.currentSec >= data.timerSec) {
                data.isTimeOver = true
            }
            if (data.currentSec == data.timerSec) {
                hapticFeedback(duration: 3, interval: 0.03)
            }
            data.currentSec += 1
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
