//
//  Category.swift
//  TodoList
//
//  Created by Сергей Юханов on 07.06.2018.
//  Copyright © 2018 Yukhanov. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    
    @objc dynamic var colour: String = ""
    
    let items = List<Item>()
}
