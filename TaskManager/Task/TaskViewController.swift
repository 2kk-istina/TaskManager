//
//  TaskViewController.swift
//  TaskManager
//
//  Created by Истина on 07/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "EntityTask", keyForSort: "taskTitle")
    
    var myTask: EntityTask?
    var myCategory: EntityCat?
    //
    typealias Select = (EntityTask?) -> ()
    var didSelect: Select?
    //
    // Choice
    @IBAction func chooseCategory(_ sender: Any) {
        performSegue(withIdentifier: "categoryToCategory", sender: nil)
    }
    //CancelInfo
    @IBAction func canselInfo(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //SaveInfo
    @IBAction func saveInfo(_ sender: Any) {
        if saveNewTask() {
            dismiss(animated: true, completion: nil)
        }
    }
    //DeleteButton
    @IBAction func deleteButton(_ sender: Any) {
        if myTask == nil {
            deleteButton.isEnabled = false
        } else {
            deleteButton.isEnabled = true
            let managedObject = myTask
            CoreDataManager.instance.managedObjectContext.delete(managedObject!)
            CoreDataManager.instance.saveContext()
            canselInfo((Any).self)
        }
        
    }
    //DatePicker
    @IBAction func datePicker(_ sender: Any) {
        finishDate.text = dateString(date: datePicker.date)
        myTask?.dateComplete = datePicker.date as NSDate
    }
    
    //Outlets:
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var taskCategory: UITextField!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var colorCategory: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var finishDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorCategory.layer.masksToBounds = true
        self.colorCategory.layer.cornerRadius = 8.0
        
        
        let date = Date()
        startDate.text = dateString(date: date)
        
        
        if let myTask = myTask {
            taskTitle.text = myTask.taskTitle
            taskCategory.text = myTask.categories?.name

            colorCategory.backgroundColor = myTask.categories?.colour as? UIColor
            datePicker.date = myTask.dateComplete! as Date
            finishDate.text = dateString(date: myTask.dateComplete! as Date)

        }
    }
    
    
    //SaveNewTask
    func saveNewTask() -> Bool {
        
        if taskTitle.text!.isEmpty {
            let alert = UIAlertController(title: "Error!",
                                          message: "Input the title of the task!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel,
                                          handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        if finishDate.text!.isEmpty {
            let alert = UIAlertController(title: "Error!",
                                          message: "Select the date, please",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel,
                                          handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        //Create new Task
        if myTask == nil {
            myTask = EntityTask()
        }
        
        if let myTask = myTask {
            myTask.taskCategory = taskCategory.text
            myTask.taskTitle = taskTitle.text
            myTask.categories = myCategory
            myTask.categories?.colour = colorCategory.backgroundColor
            myTask.dateStart = dateDate(date: startDate.text!) as NSDate
            myTask.dateComplete = dateDate(date: finishDate.text!) as NSDate
            myTask.taskComplete = false
           
            CoreDataManager.instance.saveContext()
        }
        return true
    }
    
    func dateString(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy, hh:mm"
        let dateResult = dateFormatter.string(from: date)
        
        return dateResult
    }
    
    func dateDate(date: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy, hh:mm"
        let dateResult = dateFormatter.date(from: date)!
        
        return dateResult
    }

    //AddCategory
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToCategory" {
            let viewController = segue.destination as? CategoriesViewController
            viewController!.didSelect = { [unowned self] (category) in
                if let category = category {
                    self.myCategory = category
                    self.taskCategory.text =  self.myCategory?.name
                    self.colorCategory.backgroundColor =  self.myCategory?.colour as? UIColor
                }
            }
        }
    }
}
