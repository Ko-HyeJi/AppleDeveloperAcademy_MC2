//
//  Haptic.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/16.
//

import SwiftUI

func hapticFeedback(duration: Double, interval: Double) {
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    feedbackGenerator.prepare()

    let duration = duration  // 진동을 유지할 시간 (초)
    let interval = interval  // 진동을 반복 재생할 간격 (초)

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
