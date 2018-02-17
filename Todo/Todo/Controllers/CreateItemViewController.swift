//
//  CreateItemViewController.swift
//  Todo
//
//  Created by Tevin Mantock on 2/12/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class CreateItemViewController : ModalViewController {
	let realm = try! Realm()
	var category : Category?

	override func viewDidLoad() {
		super.viewDidLoad()

		form +++ Section("Add an Item"){ section in
				section.header?.height = {100}
			}
			<<< TextRow() { row in
				row.tag = "newItem"
				row.title = "Item"
				row.placeholder = "I need to"
		}
	}

	override func cancelButtonPressed() {
		let row : TextRow? = form.rowBy(tag: "newItem")
		row?.value = ""
		super.cancelButtonPressed()
	}

	override func submitButtonPressed() {
		let row : TextRow? = form.rowBy(tag: "newItem")
		guard let value = row?.value else { return }
		guard let category = category else { return }

		if value.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
			return
		}

		let item = Item()
		item.title = value
		item.dateCreated = Date()

		do {
			try realm.write {
				category.items.append(item)
			}
		} catch {
			print("Error saving item")
		}

		super.submitButtonPressed()
	}
}
