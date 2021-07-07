//
//  Item.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 12/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var numberOfQuestion: String = ""
  @objc dynamic var answer: String = ""

    override class func primaryKey() -> String? {
        return "name"
    }
}

class Person: Object {
    @objc dynamic var email: String? = nil
    @objc dynamic var name: String? = nil
    @objc dynamic var test: TestCompleted? = nil
    @objc dynamic var check: CheckedItems? = nil
    
    
    override static func primaryKey() -> String? {
      return "name"
    }
}
class CheckedItems:Object{
    let checked = List<Bool>()
}

class TestCompleted: Object {
    let questions = List<Item>()
}



