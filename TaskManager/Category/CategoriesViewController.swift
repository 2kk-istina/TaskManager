//
//  CategoriesViewController.swift
//  TaskManager
//
//  Created by Истина on 11/06/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myCategory: EntityCat?
    //
    typealias Select = (EntityCat?) -> ()
    var didSelect: Select?
    //
    //ButtonAddNewCategory
    @IBAction func addNewCategory(_ sender: Any) {
                performSegue(withIdentifier: "catToCat", sender: nil)
    }
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "EntityCat", keyForSort: "name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCategory", for: indexPath as IndexPath) as! CategoryTableViewCell
        let category = self.fetchedResultsController.object(at: indexPath as IndexPath) as! EntityCat
        cell.textCategory.text = category.name
        cell.colorCategory.backgroundColor = category.colour as? UIColor
        cell.colorCategory.layer.masksToBounds = true
        cell.colorCategory.layer.cornerRadius = cell.colorCategory.frame.size.width/2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = fetchedResultsController.object(at: indexPath) as? EntityCat
        if let dSelect = self.didSelect {
            dSelect(category)
            dismiss(animated: true, completion: nil)
        }
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
