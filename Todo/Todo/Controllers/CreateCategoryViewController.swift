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

class CreateCategoryViewController : ModalViewController {
	let realm = try! Realm()

	let categoryLabel : UILabel = {
		let label = UILabel()
		label.text = "Enter a name for the category"

		return label
	}()

	let categoryTextField : UITextField = {
		let field = UITextField()
		field.borderStyle = .roundedRect
		field.placeholder = "Category"

		return field
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		let stackView = UIStackView(arrangedSubviews: [categoryLabel, categoryTextField])
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.distribution = .fillEqually
		view.addSubview(stackView)
		stackView.anchor(top: actionBar.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 20, paddingRight: -20, paddingBottom: 0, paddingLeft: 20, height: 0, width: 0)
	}

	override func cancelButtonPressed() {
		categoryTextField.text = ""
		super.cancelButtonPressed()
	}

	override func submitButtonPressed() {
		guard let value = categoryTextField.text else { return }

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
