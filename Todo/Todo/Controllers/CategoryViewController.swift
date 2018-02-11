//
//  CategoryViewController.swift
//  Todo
//
//  Created by Tevin Mantock on 1/6/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
	let realm = try! Realm()
	var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.separatorStyle = .none
		tableView.rowHeight = 80
        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addCatergoryButtonPressed(_ sender: UIBarButtonItem) {
        var field = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            field = alertTextField
        }
        
        alert.addAction(UIAlertAction(title: "Add Category", style: .default, handler: { (_) in
            guard let value = field.text else { return }
            let category = Category()
            category.name = value
			category.color = UIColor.randomFlat().hexValue()
            self.saveCategory(category: category)
        }))
        
        present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		guard let category = categories?[indexPath.row] else { return cell }
		let color = UIColor(hexString: category.color ?? "1D9BF6")
		cell.backgroundColor = color
		cell.textLabel?.text = category.name
		cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ItemListViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        destination.selectedCategory = categories?[indexPath.row]
    }
    
    func loadCategories() {
        self.categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
	func saveCategory(category : Category) {
        do {
			try realm.write {
				realm.add(category)
			}
        } catch {
            print("Error saving category: \(error)")
        }
        
        tableView.reloadData()
    }

	func deleteCategory(category: Category) {
		do {
			try realm.write {
				realm.delete(category)
			}
		} catch {
			print("Error deleting category")
		}
	}

	override func rightSwipeToDeleteTriggered(at indexPath: IndexPath) {
		guard let category = self.categories?[indexPath.row] else { return }
		deleteCategory(category: category)
	}
}
