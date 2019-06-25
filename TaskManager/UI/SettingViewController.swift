//
//  SettingViewController.swift
//  TaskManager
//
//  Created by Истина on 20/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBAction func backToMain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var switchNotification: UISwitch!
    @IBAction func notificSwitch(_ sender: Any) {
        if switchNotification.isOn {
            NotificationsManager.sharedInstance.rescheduleAllNotifications()
            SettingsData.sharedInstance.editSettings(notificationsEnabled: true)
        } else {
            NotificationsManager.sharedInstance.unscheduleAllNotifications()
            SettingsData.sharedInstance.editSettings(notificationsEnabled: false)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
