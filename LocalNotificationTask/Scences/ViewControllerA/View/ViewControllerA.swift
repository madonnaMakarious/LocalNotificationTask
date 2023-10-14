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
    enum State { case none, title, timeInSeconds, id }
    var state: State = .none
    
    
    private var observer: NSObjectProtocol?
    
    @IBAction func cancelAll_Action(_ sender: Any) {
        let current = UNUserNotificationCenter.current()
        current.removeAllPendingNotificationRequests()
        UserDefaults.alerts = alertsModel

    }
    
    @IBOutlet weak var Alerts_Table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        getLocalAlerts()
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            
            getLocalAlerts()
        }
    }
    
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
