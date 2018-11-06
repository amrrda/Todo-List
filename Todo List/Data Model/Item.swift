//
//  Item.swift
//  Todo List
//
//  Created by Amr Reda on 10/29/18.
//  Copyright © 2018 Amr Reda. All rights reserved.
//

import Foundation
import RealmSwift



class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items") // create an inverse realtionship to item(each item has a parent category that is a type of category and that comes from property items)
}
