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
    }
    
    var delegate: ChangeButton?
    var task: EntityTask?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
