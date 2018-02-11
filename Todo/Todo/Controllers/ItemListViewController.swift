//
//  ViewController.swift
//  Todo
//
//  Created by Tevin Mantock on 1/3/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ItemListViewController: SwipeTableViewController {
    let realm = try! Realm()
	var items : Results<Item>?
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }

	@IBOutlet weak var searchBar: UISearchBar!

	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.rowHeight = 70
		tableView.separatorStyle = .none
		tableView.tableHeaderView = searchBar
    }

	override func viewWillAppear(_ animated: Bool) {
		tableView.contentOffset = CGPoint(x: 0.0, y: searchBar.frame.size.height)
		guard let category = selectedCategory else { return }
		guard let color = category.color else { return }
		title = category.name
		updateNavigationBar(withHexCode: color)
	}

	override func viewWillDisappear(_ animated: Bool) {
		updateNavigationBar(withHexCode: "1D9BF6")
	}

	func updateNavigationBar(withHexCode colorHexCode : String) {
		guard let navigationBar = navigationController?.navigationBar else {
			fatalError("Navigation Controller was not found.")
		}
		navigationBar.barTintColor = UIColor(hexString: colorHexCode)
		searchBar.barTintColor = UIColor(hexString: colorHexCode)
		let contrast = UIColor(contrastingBlackOrWhiteColorOn: UIColor(hexString: colorHexCode), isFlat: true)
		navigationBar.tintColor = contrast
		navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : contrast as Any]
	}

    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        var field = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            field = alertTextField
        }

        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (_) in
            guard let value = field.text else { return }
			guard let category = self.selectedCategory else { return }
			do {
				try self.realm.write {
					let item = Item()
					item.title = value
					item.dateCreated = Date()
					category.items.append(item)
				}
			} catch {
					print("Error saving context")
			}

			self.tableView.reloadData()
        }))
        
        present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
		let percentage = CGFloat((items?.count ?? 1) - indexPath.row) / CGFloat((items?.count ?? 1))
		guard let item = items?[indexPath.row] else { return cell }
        cell.textLabel?.text = item.title
        cell.accessoryType = item.completed ? .checkmark : .none
		guard let color = UIColor(hexString: selectedCategory?.color ?? "1D9BF6")?.darken(byPercentage: percentage) else { return cell }
		cell.backgroundColor = color
		cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let item = items?[indexPath.row] else { return }

		do {
			try realm.write {
				item.completed = !item.completed
			}
		} catch {
			print("Error updating item status")
		}

		tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func loadItems() {
        self.items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

	func deleteItem(item : Item) {
		do {
			try realm.write {
				realm.delete(item)
			}
		} catch {
			print("Error deleting item")
		}
	}

	override func rightSwipeToDeleteTriggered(at indexPath: IndexPath) {
		guard let item = items?[indexPath.row] else { return }
		deleteItem(item: item)
	}

	override func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
		let top = CGRect(x: 0.0, y: searchBar.frame.size.height, width: 1, height: 1)
		scrollView.scrollRectToVisible(top, animated: true)

		return false
	}
}

extension ItemListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
		items = items?.filter("title CONTAINS[cd] %@", search).sorted(byKeyPath: "dateCreated", ascending: false)
		tableView.reloadData()
	}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

