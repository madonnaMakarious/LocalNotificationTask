//
//  ViewControllerBDelegate.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import UserNotifications
import Foundation

extension ViewControllerA: ViewControllerBDelegate{
    func setNotification(title: String, timeInSeconds: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeInSeconds) ?? 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
