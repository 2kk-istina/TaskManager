//
//  CategoryViewController.swift
//  TaskManager
//
//  Created by Истина on 10/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    let colors = ["purple", "mint", "blue", "orange", "pink"]
    var selectedColor = "mint"
    var category: EntityCat?
    @IBAction func cancelCategory(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveCategory(_ sender: Any) {
        if saveNewCategory() {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var textFieldCategory: UITextField!
    @IBOutlet weak var colorPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
            if let category = category {
                self.textFieldCategory.text = category.name
                var color = UIColor(named: selectedColor)
                color = category.colour as? UIColor
        }
    }
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
            category.colour = UIColor(named: selectedColor)
            CoreDataManager.instance.saveContext()
        }
        return true
    }
}
extension CategoryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var label: UILabel
    if let view = view as? UILabel { label = view } else {
    label = UILabel()}
    label.textColor = UIColor.blue
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.text = colors[row]
    return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedColor = colors[row]
    }
}
