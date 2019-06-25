//
//  NotificationsManager.swift
//  TaskManager
//
//  Created by Истина on 20/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class NotificationsManager {
    static let sharedInstance = NotificationsManager()
    var myTask: EntityTask?
//    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    weak var delegate = UIApplication.shared.delegate as? AppDelegate
    //
    func newNotification(date: Date, uuid: String, body: String) {
        delegate?.scheduleNotification(
            atDate: date,
            title: "You have something to do, remember?",
            body: body,
            uuid: uuid)
    }
    //
    func unscheduleAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    func rescheduleAllNotifications() {
        if let myTask = myTask {
            if myTask.notification == true {
                //schedule notification
                newNotification(date: myTask.dateComplete! as Date, uuid: myTask.uuid!, body: myTask.taskTitle!)
            }
        }
    }
}
