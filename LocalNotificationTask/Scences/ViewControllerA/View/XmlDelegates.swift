//
//  XmlDelegates.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import Alamofire

extension ViewControllerA: XMLParserDelegate {
    
    func getLocalAlerts() {
        self.ShowLoadingIndicator()
        AF.request("https://lynxapp.com/localalerts.php").responseString { (dataResponse: AFDataResponse<String>) in
            switch dataResponse.result {
            case .success(let xmlString):
                self.alertsModel = []
                self.parser = XMLParser(data: xmlString.data(using: .utf8)!)
                self.parser.delegate = self
                let success = self.parser.parse()
                if success {
                    print("parse success")
                } else {
                    self.showAlertMessage(title: " ", msg: " check with backend", selfDismissing: true, time: 1.5)
                }
            case .failure(let error):
                print(error)
            }
            self.StopLoadingIndicator()
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        switch elementName {
        case "notification" :
            self.newAlert = LocalAlertModel(title: "", timeInSeconds: 0.0, id: 0)
            self.state = .none
        case "title":
            self.state = .title
        case "timeInSeconds":
            self.state = .timeInSeconds
        case "id":
            self.state = .id
        default:
            self.state = .none
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let newAlert = self.newAlert, elementName == "notification" {
            self.alertsModel.append(newAlert)
            self.newAlert = nil
        }
        self.state = .none
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let _ = self.newAlert else { return }
        switch self.state {
        case .title:
            self.newAlert!.title = string
        case .timeInSeconds:
            self.newAlert!.timeInSeconds = Double(string) ?? 0.0
        case .id:
            self.newAlert!.id = Int(string) ?? 0
        default:
            break
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        Alerts_Table.reloadData()
        UserDefaults.alerts = alertsModel
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
    }
}
