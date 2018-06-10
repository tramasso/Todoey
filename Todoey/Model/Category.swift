//
//  Category.swift
//  Todoey
//
//  Created by Lucas Tramasso on 6/5/18.
//  Copyright © 2018 Lucas Tramasso. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
