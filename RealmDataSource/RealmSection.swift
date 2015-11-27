//
//  RealmSection.swift
//  RealmDataSource
//
//  Created by Matthias Buchetics on 27/11/15.
//  Copyright © 2015 all about apps GmbH. All rights reserved.
//

import Foundation
import RealmSwift
import DataSource

/**
    Representation of a table section where the rows are the results of a Realm query.
    Note that all rows have the same row identifier.
 */
public struct RealmSection<T: Object>: SectionType {
    /// Optional title of the section
    public let title: String?
    
    /// Row identifier for all rows of this section
    public let rowIdentifier: String
    
    /// Realm query results representing the rows of this section
    public var results: Results<T>?
    
    public init() {
        self.title = nil
        self.rowIdentifier = ""
    }
    
    public init(title: String? = nil, rowIdentifier: String, results: Results<T>) {
        self.results = results
        self.title = title
        self.rowIdentifier = rowIdentifier
    }
    
    public subscript(index: Int) -> Row<T> {
        return Row(identifier: rowIdentifier, data: results![index])
    }
    
    public subscript(index: Int) -> RowType {
        return Row(identifier: rowIdentifier, data: results![index])
    }
    
    public var numberOfRows: Int {
        return results!.count
    }
    
    public var hasTitle: Bool {
        if let title = title where !title.isEmpty {
            return true
        }
        else {
            return false
        }
    }
}