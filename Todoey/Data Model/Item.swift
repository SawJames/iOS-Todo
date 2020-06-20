//
//  Item.swift
//  Todoey
//
//  Created by saw Tarmalar on 20/06/2020.
//  Copyright © 2020 saw Tarmalar. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
