//
//  SetariViewController.swift
//  Stam Acasa
//
//  Created by Macbook on 4/15/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit
import UserNotifications

class SetariViewController: UIViewController {
    @IBOutlet weak var setariSwitchLabel: UISwitch!
    var sceneDelegate = UIApplication.shared.connectedScenes
    .first!.delegate as! SceneDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setariSwitchLabel.isOn = StamAcasaSingleton.sharedInstance.getFromUserDefaults("switch") ?? false
        // Do any additional setup after loading the view.
    }
    
    func setLocalNotification(){
        if setariSwitchLabel.isOn{
            self.sceneDelegate.scheduleNotification(notificationType: "Notificare")
        } else{
            UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                var identifiers: [String] = []
                for notification:UNNotificationRequest in notificationRequests {
                    if notification.identifier == "Local Notification" {
                        identifiers.append(notification.identifier)
                    }
                }
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
            }
        }
    }
    
    @IBAction func setariSwitchTapped(_ sender: Any) {
        StamAcasaSingleton.sharedInstance.saveToUserDefaults("switch", value: setariSwitchLabel.isOn)
        setLocalNotification()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
