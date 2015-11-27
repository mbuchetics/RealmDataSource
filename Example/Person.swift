//
//  Person.swift
//  RealmDataSource
//
//  Created by Matthias Buchetics on 27/11/15.
//  Copyright © 2015 all about apps GmbH. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Person: Object {
    dynamic var firstName = ""
    dynamic var lastName = ""
    
    required init() {
        super.init()
    }
    
    override init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    convenience init(firstName: String, lastName: String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
    }
}