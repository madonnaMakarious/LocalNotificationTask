//
//  ViewControllerB.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import UIKit

protocol ViewControllerBDelegate: AnyObject {
    func setNotification(title: String, timeInSeconds: String)
}
class ViewControllerB: UIViewController {

    var isScheduled = false
    var isRepeated = false
    
    var alertTitle: String = ""
    var timeInSeconds: String = ""
    
    @IBOutlet weak var AlertTitle_lbl: UILabel!
    
    @IBAction func repeatNotification_switch(_ sender: UISwitch) {
//        if sender.isOn{
//            isRepeated = true
//        }else{
//            isRepeated = false
//        }
    }
    @IBAction func scheduleNotification_switch(_ sender: UISwitch) {
        if sender.isOn{
            isScheduled = true
        }else{
            isScheduled = false
        }
    }

    
    @IBAction func SaveActions(_ sender: Any) {
        if isScheduled{
            delegate?.setNotification(title: alertTitle, timeInSeconds: timeInSeconds)
            self.navigationController?.popViewController(animated: true)
        }
    }

    
    weak var delegate: ViewControllerBDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        AlertTitle_lbl.text = alertTitle
        // Do any additional setup after loading the view.
    }
}
