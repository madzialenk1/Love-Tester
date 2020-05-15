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
  @objc dynamic var t: String = ""
  @objc dynamic var a: String = ""
    
    override class func primaryKey() -> String? {
        return "t"
    }
}
