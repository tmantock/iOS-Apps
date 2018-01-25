//
//  Category.swift
//  Todo
//
//  Created by Tevin Mantock on 1/11/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
	@objc dynamic var name : String = ""
	@objc dynamic var color : String?
	let items = List<Item>()
}
