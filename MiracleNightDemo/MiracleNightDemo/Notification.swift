//
//  Notification.swift
//  MainView
//
//  Created by 고혜지 on 2023/05/03.
//

import UserNotifications

func RequestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        // 권한 요청 결과 처리
        if let error = error {
            // 권한 요청 중 오류가 발생한 경우
            print("Error requesting notification authorization: \(error.localizedDescription)")
        } else if granted {
            // 사용자가 알림 권한을 승인한 경우
            print("Notification authorization granted.")
        } else {
            // 사용자가 알림 권한을 거부한 경우
            print("Notification authorization denied.")
        }
    }
}

func SendNotification() {
    let content = UNMutableNotificationContent()
    content.title = "☽ Miracle Night ☽"
//    content.subtitle = "밤정리"
    content.body = "당신의 방을 정리할 시간입니다\n지금 정리를 시작해주세요 🧹"
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//    let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: 21, minute: 30), repeats: false)
    
    let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
}
