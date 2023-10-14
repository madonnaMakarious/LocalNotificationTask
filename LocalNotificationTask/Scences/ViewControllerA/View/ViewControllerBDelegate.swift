//
//  ViewControllerBDelegate.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import UserNotifications
import Foundation

extension ViewControllerA: ViewControllerBDelegate{
    func setIsRepeatedOnUserDefaults(isRepeated: Bool, id: Int) {
        
        guard let item = alertsModel.firstIndex(where: { $0.id == id }) else { return }
        alertsModel[item].isRepeated = isRepeated
        UserDefaults.alerts = alertsModel
    }
    
    func setIsScheduledOnUserDefaults(isScheduled: Bool, id: Int) {
        guard let item = alertsModel.firstIndex(where: { $0.id == id }) else { return }
        alertsModel[item].isScheduled = isScheduled
        UserDefaults.alerts = alertsModel
    }
    
    func setNotification(title: String, timeInSeconds: Double, isRepeated: Bool, ID: Int){
        
        var defaultSeconds = timeInSeconds
        if defaultSeconds < 60{
            defaultSeconds = 60
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default
        content.userInfo = ["NotificationID": ID]
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Date().addingTimeInterval(timeInSeconds).timeIntervalSinceNow, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification.start.\(ID)", content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if isRepeated{
                    if let firstRepeatingDate = Calendar.current.date(byAdding: .second, value: Int(defaultSeconds), to: Date().addingTimeInterval(timeInSeconds)) {
                        let repeatingTrigger = UNTimeIntervalNotificationTrigger(timeInterval: firstRepeatingDate.timeIntervalSinceNow, repeats: true)
                        let repeatingRequest = UNNotificationRequest(identifier: "notification.repeater.\(ID)", content: content, trigger: repeatingTrigger)
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
