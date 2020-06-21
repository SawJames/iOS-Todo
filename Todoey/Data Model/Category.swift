//
//  Category.swift
//  Todoey
//
//  Created by saw Tarmalar on 20/06/2020.
//  Copyright © 2020 saw Tarmalar. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
