//
//  Item.swift
//  Todoey
//
//  Created by Lucas Tramasso on 6/5/18.
//  Copyright © 2018 Lucas Tramasso. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var completed : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
