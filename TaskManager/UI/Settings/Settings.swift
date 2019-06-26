//
//  Settings.swift
//  TaskManager
//
//  Created by Истина on 25/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SettingsData {
    static let sharedInstance = SettingsData()
    var mySettings: EntitySettings?
    func editSettings(notificationsEnabled: Bool) {
        if mySettings != nil {
            mySettings?.notification = notificationsEnabled
        }
    }
}
