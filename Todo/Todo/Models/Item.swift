//
//  Item.swift
//  Todo
//
//  Created by Tevin Mantock on 1/11/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
	@objc dynamic var title : String = ""
	@objc dynamic var completed : Bool = false
	@objc dynamic var dateCreated : Date?
	var category = LinkingObjects(fromType: Category.self, property: "items")
}
