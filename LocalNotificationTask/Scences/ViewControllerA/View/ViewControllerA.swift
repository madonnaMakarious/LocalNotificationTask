//
//  ViewControllerA.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import UIKit

import Alamofire



class ViewControllerA: BaseVC {

    var parser = XMLParser()
    var newAlert: LocalAlertModel?
    var alertsModel: [LocalAlertModel] = []
    enum State { case none, title, timeInSeconds }
    var state: State = .none
    
    @IBAction func cancelAll_Action(_ sender: Any) {
        let current = UNUserNotificationCenter.current()
        current.removeAllPendingNotificationRequests()
    }
    
    @IBOutlet weak var Alerts_Table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocalAlerts()
    }
}
