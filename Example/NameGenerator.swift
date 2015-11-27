//
//  NameGenerator.swift
//  Example
//
//  Created by Matthias Buchetics on 27/11/15.
//  Copyright © 2015 all about apps GmbH. All rights reserved.
//

import Foundation

struct NameGenerator {
    static var json: NSDictionary? = {
        guard let path = NSBundle.mainBundle().pathForResource("names", ofType: "json"),
              let data = NSData(contentsOfFile: path),
              let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
            else { return nil }
        
        return json as? NSDictionary
    }()
    
    static func randomValue(key: String) -> String {
        guard let values = json?[key] as? Array<String> else { return "" }
        let index = Int(arc4random_uniform(UInt32(values.count)))
        return values[index]
    }
    
    static var firstName: String {
        return randomValue("first_name")
    }
    
    static var lastName: String {
        return randomValue("last_name")
    }
}