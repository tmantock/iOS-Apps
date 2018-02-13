//
//  SwipeTableViewController.swift
//  Todo
//
//  Created by Tevin Mantock on 1/18/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

	var cell : UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
		cell.delegate = self

		return cell
	}

	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		guard orientation == .right else { return nil }

		let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
			self.rightSwipeToDeleteTriggered(at: indexPath)
		}

		deleteAction.image = UIImage(named: "delete")

		return [deleteAction]
	}

	func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
		var options = SwipeTableOptions()
		options.expansionStyle = .destructive

		return options
	}

	func rightSwipeToDeleteTriggered(at indexPath : IndexPath) {

	}
}
