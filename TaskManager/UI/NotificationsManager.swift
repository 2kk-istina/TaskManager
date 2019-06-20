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
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    weak var delegate = UIApplication.shared.delegate as? AppDelegate
    let uuidString = UUID().uuidString
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
    //
//    func rescheduleAllNotifications() {
//        //let request = NSFetchRequest<Task>(entityName: "Task")
//
//        do {
//            let searchResults = try context.fetch(request)
//
//            for task in searchResults {
//
//                if task.notificationEnabled == true {
//
//                    //schedule notification
//                    newNotification(date: task.date, uuid: task.uuid!, body: task.taskDescription!)
//                }
//            }
//
//        } catch {
//            print("Error with request: \(error)")
//        }
//
//        //(UIApplication.shared.delegate as! AppDelegate).saveContext()
//    }
}
