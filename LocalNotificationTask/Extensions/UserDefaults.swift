//
//  UserDefaults.swift
//  LocalNotificationTask
//
//  Created by Donna on 14/10/2023.
//

import Foundation
import UIKit

extension UserDefaults {
    
    private enum Keys {
        static let alerts = "alerts"
    }
        
    class var alerts: [LocalAlertModel]? {
        get {
            return UserDefaults.standard.getDecodable([LocalAlertModel].self, forKey: Keys.alerts)
        }
        set {
            UserDefaults.standard.setEncodable(newValue, forKey: Keys.alerts)
        }
    }
    
        
    func setEncodable<T: Encodable>(_ encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func getDecodable<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
    
}
