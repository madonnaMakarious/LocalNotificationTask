//
//  ViewControllerATableDelegates.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import UIKit

extension ViewControllerA: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Alerts_Table.dequeueReusableCell(withIdentifier: "cell")
            
        cell!.textLabel?.text = alertsModel[indexPath.row].title
        cell!.clipsToBounds = true
        cell!.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewControllerB") as! ViewControllerB
        nextVC.delegate = self
        nextVC.alertTitle = alertsModel[indexPath.row].title
        nextVC.timeInSeconds = alertsModel[indexPath.row].timeInSeconds
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
