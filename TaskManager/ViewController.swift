//
//  ViewController.swift
//  TaskManager
//
//  Created by Истина on 06/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, ChangeButton {
    var myTask: EntityTask?
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addNewTask(_ sender: Any) {
        performSegue(withIdentifier: "taskManagerToTask", sender: nil)
    }
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "EntityTask", keyForSort: "taskCategory")
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath as IndexPath) as! taskCell
        let task = self.fetchedResultsController.object(at: indexPath as IndexPath) as! EntityTask
        cell.taskTitle.text = task.taskTitle
        cell.catName.text = task.taskCategory
        cell.prioritySign.backgroundColor = task.categories?.colour as? UIColor
        cell.dateStart.text = dateString(date: task.dateStart! as Date)
        cell.dateFinish.text = dateString(date: task.dateComplete! as Date)
        if task.taskComplete {
            cell.checkBoxOutlet.setImage(UIImage(named: "Checkmark"), for: .normal)
        } else {
            cell.checkBoxOutlet.setImage(UIImage(named: "Checkmarkempty"), for: .normal)
        }
        cell.delegate = self
        cell.task = task
        return cell
    }
    func changeButton(checked: EntityTask  ) {
        if checked.taskComplete == true {
            checked.taskComplete = false
        } else {
            checked.taskComplete = true
        }
        CoreDataManager.instance.saveContext()
        CoreDataManager.instance.managedObjectContext.refreshAllObjects()
        tableView.reloadInputViews()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = fetchedResultsController.object(at: indexPath) as? EntityTask
        performSegue(withIdentifier: "taskManagerToTask", sender: task)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskManagerToTask" {
            let controller = segue.destination as! TaskViewController
            controller.myTask = sender as? EntityTask
        }
    }
    func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy, hh:mm"
        let dateResult = dateFormatter.string(from: date)
        return dateResult
    }
    // MARK: - FetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        @unknown default:
            fatalError()
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    //DeleteRow
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.managedObjectContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
}
