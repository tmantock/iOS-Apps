//
//  CreateCategoryViewController.swift
//  Todo
//
//  Created by Tevin Mantock on 2/11/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
import Eureka

class CreateCategoryViewController : ModalViewController {
	let realm = try! Realm()

	override func viewDidLoad() {
		super.viewDidLoad()

		form +++ Section("Add a Category"){ section in
			section.header?.height = {100}
			}
			<<< TextRow() { row in
				row.tag = "newCategory"
				row.title = "Category"
				row.placeholder = "This is for"
		}
	}

	override func cancelButtonPressed() {
		super.cancelButtonPressed()
	}

	override func submitButtonPressed() {
		let row : TextRow? = form.rowBy(tag: "newCategory")
		guard let value = row?.value else { return }

		if value.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
			return
		}

		let category = Category()
		category.name = value
		category.color = UIColor.randomFlat().hexValue()

		self.saveCategory(category: category)
		super.submitButtonPressed()
	}

	func saveCategory(category : Category) {
		do {
			try realm.write {
				realm.add(category)
			}
		} catch {
			print("Error saving category: \(error)")
		}
	}
}
