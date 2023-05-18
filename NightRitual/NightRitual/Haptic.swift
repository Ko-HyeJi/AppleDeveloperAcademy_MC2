import SwiftUI

func hapticFeedback(duration: Double, interval: Double) {
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    feedbackGenerator.prepare()

    let duration = duration
    let interval = interval

    var timer: Timer?
    var elapsedTime = 0.0

    timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
        feedbackGenerator.impactOccurred()
        elapsedTime += interval
        
        if elapsedTime >= duration {
            timer?.invalidate()
        }
    }

    RunLoop.current.add(timer!, forMode: .common)
}
