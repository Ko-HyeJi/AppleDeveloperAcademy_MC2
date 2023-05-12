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

func SendNotification(notificationTime: DateComponents) {
    let content = UNMutableNotificationContent()
    content.title = "밤정리"
    content.body = "새로운 하루가 시작되었어요.\n어제의 정리정돈 덕분에 오늘의 시작을 더 가볍게!"
    content.sound = UNNotificationSound.default
    
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//    let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: 23, minute: 52), repeats: false)
    let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
    
    let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
}
