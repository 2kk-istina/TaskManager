//
//  ViewController.swift
//  TaskManager
//
//  Created by Истина on 06/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController, ChangeButton {

    @IBOutlet weak var tableView: UITableView!

    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "EntityTask", keyForSort: "taskComplete")
    var myTask: EntityTask?

    @IBAction func addNewTask(_ sender: Any) {
        performSegue(withIdentifier: R.segue.viewController.taskManagerToTask, sender: nil)
    }
    @IBAction func goToSettings(_ sender: Any) {
        performSegue(withIdentifier: R.segue.viewController.taskToSettings, sender: nil)
    }

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

    func changeButton(checked: EntityTask  ) {
        if checked.taskComplete == true {
            checked.taskComplete = false
            checked.notification = false
        } else {
            checked.taskComplete = true
            checked.notification = true
        }
        CoreDataManager.instance.saveContext()
        CoreDataManager.instance.managedObjectContext.refreshAllObjects()
        tableView.reloadInputViews()
    }
    func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy, hh:mm"
        let dateResult = dateFormatter.string(from: date)
        return dateResult
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskcell, for: indexPath as IndexPath) else {
            fatalError("DequeueReusableCell failed while casting")
        }
        guard let task = self.fetchedResultsController.object(at: indexPath as IndexPath) as? EntityTask else {
            fatalError("Failed while casting")
        }
        cell.taskTitle.text = task.taskTitle
        cell.catName.text = task.taskCategory
        cell.prioritySign.backgroundColor = task.categories?.colour as? UIColor
        cell.dateStart.text = dateString(date: task.dateStart! as Date)
        cell.dateFinish.text = dateString(date: task.dateComplete! as Date)
        if task.taskComplete {
            cell.checkBoxOutlet.setImage(R.image.checkmark(), for: .normal)
            cell.prioritySign.backgroundColor = R.color.frog()
            cell.backgroundColor = R.color.frog()
        } else {
            cell.checkBoxOutlet.setImage(R.image.checkmarkempty(), for: .normal)
            cell.prioritySign.backgroundColor = task.categories?.colour as? UIColor
            cell.backgroundColor = UIColor.white
        }
        cell.delegate = self
        cell.task = task
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = fetchedResultsController.object(at: indexPath) as? EntityTask
        performSegue(withIdentifier: R.segue.viewController.taskManagerToTask, sender: task)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cotroller = R.segue.viewController.taskManagerToTask(segue: segue) {
            cotroller.destination.myTask = sender as? EntityTask
        }
    }
    //DeleteRow
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let managedObject = fetchedResultsController.object(at: indexPath) as? NSManagedObject else {
                fatalError("Error")
            }
            CoreDataManager.instance.managedObjectContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
}
extension ViewController: NSFetchedResultsControllerDelegate {
    // MARK: - FetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
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
}
