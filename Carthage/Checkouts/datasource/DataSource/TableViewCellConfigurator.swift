//
//  TableViewCellConfigurator.swift
//  Example
//
//  Created by Matthias Buchetics on 26/11/15.
//  Copyright © 2015 aaa - all about apps GmbH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols

public protocol TableViewCellConfiguratorType {
    var rowIdentifier: String { get }
    var cellIdentifier: String { get }
    
    func configureRow(row: RowType, cell: UITableViewCell)
}

// MARK: - TableViewCellConfigurator

public class TableViewCellConfigurator<T, C: UITableViewCell>: TableViewCellConfiguratorType {
    /// Row identifier this configurator is responsible for
    public var rowIdentifier: String
    
    /// Cell identifier used to dequeue a table view cell
    public var cellIdentifier: String
    
    /// Typed configuration closure
    var configure: (T, C, String) -> Void
    
    /// Initializes the configurator given row and cell identifiers and a configure closure
    public init (rowIdentifier: String, cellIdentifier: String, configure: (data: T, cell: C, rowIdentifier: String) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.rowIdentifier = rowIdentifier
        self.configure = configure
    }
    
    /// Initializes the configurator using the same identifier for rowIdentifier and cellIdentifier and a configure closure
    public convenience init (_ cellIdentifier: String, configure: (data: T, cell: C, rowIdentifier: String) -> Void) {
        self.init(rowIdentifier: cellIdentifier, cellIdentifier: cellIdentifier, configure: configure)
    }
    
    /// Takes a row and cell, makes the required casts and calls the configure closure
    public func configureRow(row: RowType, cell: UITableViewCell) {
        if let row = row as? Row<T>, cell = cell as? C {
            configure(row.data, cell, row.identifier)
        }
    }
}