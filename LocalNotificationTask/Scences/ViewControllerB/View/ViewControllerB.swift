//
//  ViewControllerB.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import UIKit

protocol ViewControllerBDelegate: AnyObject {
    func setIsRepeatedOnUserDefaults(isRepeated: Bool, id: Int)
    func setIsScheduledOnUserDefaults(isScheduled: Bool, id: Int)
    func setNotification(title: String, timeInSeconds: Double, isRepeated: Bool, ID: Int)
}

class ViewControllerB: BaseVC {
    
    var id = 0
    var object: LocalAlertModel!
    
    weak var delegate: ViewControllerBDelegate?
    @IBOutlet weak var scheduledSwitch: UISwitch!
    @IBOutlet weak var AlertTitle_lbl: UILabel!
    @IBOutlet weak var repeatedSwitch: UISwitch!
    
    @IBAction func repeatNotification_switch(_ sender: UISwitch) {
        deleteLocalNotification(identifier: "notification.repeater.\(object.id)")
        if sender.isOn && object.isScheduled{
            object.isRepeated = true
            delegate?.setIsRepeatedOnUserDefaults(isRepeated: object.isRepeated, id: object.id)
            
            delegate?.setNotification(title: object.title, timeInSeconds: object.timeInSeconds, isRepeated: object.isRepeated, ID: object.id)
            
        }else if !object.isScheduled && sender.isOn{
            sender.isOn = false
            showAlertMessage(title: "Sorry", msg: "turn on schedule notification first", selfDismissing: true, time: 1)
        }else{
            object.isRepeated = false
            delegate?.setIsRepeatedOnUserDefaults(isRepeated: object.isRepeated, id: object.id)
        }
        
    }
    
    
    @IBAction func scheduleNotification_switch(_ sender: UISwitch) {
        deleteLocalNotification(identifier: "notification.start.\(object.id)")
        if sender.isOn{
            object.isScheduled = true
            delegate?.setNotification(title: object.title, timeInSeconds: object.timeInSeconds, isRepeated: object.isRepeated, ID: object.id)
        }else{
            if object.isRepeated{
                repeatedSwitch.isOn = false
                deleteLocalNotification(identifier: "notification.repeater.\(object.id)")
                delegate?.setIsRepeatedOnUserDefaults(isRepeated: object.isRepeated, id: object.id)
            }
            object.isScheduled = false
        }
        delegate?.setIsScheduledOnUserDefaults(isScheduled: object.isScheduled, id: object.id)
    }
    
    private func deleteLocalNotification(identifier: String){
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == identifier{
                    identifiers.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        object = UserDefaults.alerts?.first(where: {$0.id == id})
        
        AlertTitle_lbl.text = object.title
        scheduledSwitch.isOn = object.isScheduled
        repeatedSwitch.isOn = object.isRepeated
    }
}
