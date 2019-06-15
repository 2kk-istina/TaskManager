//
//  taskCell.swift
//  TaskManager
//
//  Created by Истина on 06/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit

protocol ChangeButton {
    func changeButton(checked: EntityTask)
}

class taskCell: UITableViewCell {
    
    
  
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var prioritySign: UILabel!
    @IBOutlet weak var dateStart: UILabel!
    @IBOutlet weak var dateFinish: UILabel!
    @IBOutlet weak var checkBoxOutlet: UIButton!
    
    
    @IBAction func checkBoxAction(_ sender: Any) {
        delegate?.changeButton(checked: task ?? EntityTask())
//        if task!.taskComplete {
//            delegate?.changeButton(checked: false)
//        } else {
//            delegate?.changeButton(checked: true)
//        }
//        delegate?.changeButton(checked: self)
    }
    
    var delegate: ChangeButton?
    var task: EntityTask?

}
