//
//  Category.swift
//  Todo List
//
//  Created by Amr Reda on 10/29/18.
//  Copyright © 2018 Amr Reda. All rights reserved.
//

import Foundation
import RealmSwift



class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>() // create a new forward relationship
    
}
