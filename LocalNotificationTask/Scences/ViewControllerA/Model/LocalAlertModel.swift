//
//  LocalAlertModel.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import Foundation

struct LocalAlertModel: Codable{
    var title: String = ""
    var timeInSeconds: Double = 0.0
    var id : Int = 0
    var isRepeated: Bool = false
    var isScheduled: Bool = false
    
    
}
