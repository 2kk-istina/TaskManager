//
//  CategoryViewController.swift
//  TaskManager
//
//  Created by Истина on 10/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    var category: EntityCat?
    var myColor: UIColor = .white
    //CancelCategory
    @IBAction func cancelCategory(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //Save
    @IBAction func saveCategory(_ sender: Any) {
        if saveNewCategory() {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var textFieldCategory: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        //createDropdown()
//            if let category = category {
//                self.textFieldCategory.text = category.name
//                myColor = category.colour as! UIColor
//        }
    }
//    func createDropdown() {
//        dropDownColor.optionArray = ["red", "blue", "green", "cyan"]
//        dropDownColor.rowBackgroundColor = .white
//        dropDownColor.didSelect { (selectedText, _, _) in
//            guard let color = Color(rawValue: selectedText) else {return}
//            self.myColor = color.create
//        }
//    }
    func saveNewCategory() -> Bool {
        if textFieldCategory.text!.isEmpty {
            let alert = UIAlertController(title: "Error!", message: "Input the Category!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        if category == nil {
            category = EntityCat()
        }
        if let category = category {
            category.name = textFieldCategory.text
            category.colour = myColor
            CoreDataManager.instance.saveContext()
        }
        return true
    }
}

//enum Color: String {
//    case red
//    case blue
//    case green
//    case cyan
//    var create: UIColor {
//        switch self {
//        case .red:
//            return UIColor.red
//        case .blue:
//            return UIColor.blue
//        case .green:
//            return UIColor.green
//        case .cyan:
//            return UIColor.cyan
//        }
//    }
//}
