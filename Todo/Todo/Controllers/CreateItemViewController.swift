//
//  CreateItemViewController.swift
//  Todo
//
//  Created by Tevin Mantock on 2/12/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit

class CreateItemViewController : ModalViewController {
	var itemDelegate: CreateItemViewControllerDelegate? {
		get { return self.delegate as? CreateItemViewControllerDelegate }
		set { self.delegate = newValue }
	}

	let itemLabel : UILabel = {
		let label = UILabel()
		label.text = "Enter a name for the item"

		return label
	}()

	let itemTextField : UITextField = {
		let field = UITextField()
		field.borderStyle = .roundedRect
		field.placeholder = "Category"

		return field
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		let stackView = UIStackView(arrangedSubviews: [itemLabel, itemTextField])
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.distribution = .fillEqually
		view.addSubview(stackView)
		stackView.anchor(top: actionBar.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 20, paddingRight: -20, paddingBottom: 0, paddingLeft: 20, height: 0, width: 0)
	}

	override func cancelButtonPressed() {
		itemTextField.text = ""
		super.cancelButtonPressed()
	}

	override func submitButtonPressed() {
		guard let value = itemTextField.text else { return }

		if value.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
			return
		}

		let item = Item()
		item.title = value
		item.dateCreated = Date()

		itemDelegate?.saveItem(item: item)
		super.submitButtonPressed()
	}
}

protocol CreateItemViewControllerDelegate : ModalViewControllerDelegate {
	func saveItem(item : Item)
}
