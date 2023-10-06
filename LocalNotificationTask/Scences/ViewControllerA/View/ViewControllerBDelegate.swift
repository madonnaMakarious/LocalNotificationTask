//
//  ViewControllerBDelegate.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import UserNotifications
import Foundation

extension ViewControllerA: ViewControllerBDelegate{
    func setNotification(title: String, timeInSeconds: String, isRepeated: Bool){
        
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Date().addingTimeInterval(Double(timeInSeconds) ?? 1.0).timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        
        
        UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if isRepeated{
                        if let firstRepeatingDate = Calendar.current.date(byAdding: .day, value: 1, to: Date().addingTimeInterval(Double(timeInSeconds) ?? 1.0)) {
                            let repeatingTrigger = UNTimeIntervalNotificationTrigger(timeInterval: firstRepeatingDate.timeIntervalSinceNow, repeats: true)
                            let repeatingRequest = UNNotificationRequest(identifier: "notification.repeater", content: content, trigger: repeatingTrigger)
                            UNUserNotificationCenter.current().add(repeatingRequest) { (error) in
                                if let error = error {
                                    print("Error adding repeating notification: \(error.localizedDescription)")
                                } else {
                                    print("Successfully scheduled")
                                }
                            }
                        }
                    }
                    
                }
            }

    }
}
