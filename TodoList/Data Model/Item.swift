//
//  Item.swift
//  TodoList
//
//  Created by Сергей Юханов on 07.06.2018.
//  Copyright © 2018 Yukhanov. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
