//
//  BaseClass.swift
//  LocalNotificationTask
//
//  Created by Donna on 06/10/2023.
//

import UIKit

protocol BaseProtocol: AnyObject{
    func ShowLoadingIndicator()
    func StopLoadingIndicator()
    func showAlertMessage(title: String , msg: String,selfDismissing: Bool ,
                          time: TimeInterval)
}

class BaseVC: UIViewController {

    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        indicator.color = .darkGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    func layoutUI(){
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}

extension BaseVC: BaseProtocol{
    func showAlertMessage(title: String, msg: String, selfDismissing: Bool, time: TimeInterval) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        alert.title = title
        alert.message = msg

        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }

        present(alert, animated: true)

        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
                timer.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }
    
    func ShowLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func StopLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
}

