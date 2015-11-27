//
//  TableViewDataSource.swift
//  Example
//
//  Created by Matthias Buchetics on 24/11/15.
//  Copyright © 2015 aaa - all about apps GmbH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - TableViewDataSource

/**
    Wraps a `DataSource` and uses `TableViewCellConfigurator`s to dequeue and configure table view cells.
    Implements `UITableViewDataSource` and `DataSourceType` protocols.
*/
public class TableViewDataSource: NSObject {
    /// The data source
    public var dataSource: DataSource
    
    /// Whether to show section titles
    public var showSectionTitles: Bool?
    
    var configurators = Dictionary<String, TableViewCellConfiguratorType>()
    
    /// Initializes the table view data source with a single cell configurator
    public init (dataSource: DataSource, configurator: TableViewCellConfiguratorType) {
        self.dataSource = dataSource
        self.configurators[configurator.rowIdentifier] = configurator
    }
    
    /// Initializes the table view data source with multiple cell configurators
    public init (dataSource: DataSource, configurators: Array<TableViewCellConfiguratorType>) {
        self.dataSource = dataSource
        
        for configurator in configurators {
            self.configurators[configurator.rowIdentifier] = configurator
        }
    }
    
    /// Add a cell configurator
    public func addConfigurator(configurator: TableViewCellConfiguratorType) {
        configurators[configurator.rowIdentifier] = configurator
    }
    
    /**
        Tries to get the appropriate cell configurator given the specified row identifier.
        If no cell configurator for the specified row identifier is found, the default configurator with identifier "" (empty string) is used if available.
     */
    public func configuratorForRowIdentifier(rowIdentifier: String) -> TableViewCellConfiguratorType? {
        if let configurator = self.configurators[rowIdentifier] {
            return configurator
        }
        else if let configurator = self.configurators[""] {
            return configurator
        }
        else {
            return nil
        }
    }
}

// MARK: - UITableViewDataSource

extension TableViewDataSource: UITableViewDataSource {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.numberOfSections
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInSection(section)
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = dataSource.rowAtIndexPath(indexPath)
        let configurator = configuratorForRowIdentifier(row.identifier)!
        let cell = tableView.dequeueReusableCellWithIdentifier(configurator.cellIdentifier, forIndexPath: indexPath)
        
        configurator.configureRow(row, cell: cell)
        
        return cell
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let showTitles = showSectionTitles ?? (dataSource.numberOfSections > 1)
        
        if showTitles && dataSource.numberOfRowsInSection(section) > 0 {
            return dataSource.sections[section].title
        }
        else {
            return nil
        }
    }
}

// MARK: - DataSourceType
extension TableViewDataSource: DataSourceType {
    // MARK: Rows
    
    public func numberOfRowsInSection(section: Int) -> Int {
        return dataSource.numberOfRowsInSection(section)
    }
    
    public func rowAtIndexPath(indexPath: NSIndexPath) -> RowType {
        return dataSource.rowAtIndexPath(indexPath)
    }
    
    public func rowAtIndexPath<T>(indexPath: NSIndexPath) -> Row<T> {
        return dataSource.rowAtIndexPath(indexPath)
    }
    
    // MARK: Sections
    
    public var numberOfSections: Int {
        return dataSource.numberOfSections
    }
    
    public var firstSection: SectionType? {
        return dataSource.firstSection
    }
    
    public var lastSection: SectionType? {
        return dataSource.lastSection
    }
    
    public func sectionAtIndexPath<T>(indexPath: NSIndexPath) -> Section<T> {
        return dataSource.sectionAtIndexPath(indexPath)
    }
    
    public func sectionAtIndexPath(indexPath: NSIndexPath) -> SectionType {
        return dataSource.sectionAtIndexPath(indexPath)
    }
    
    public func sectionAtIndex<T>(index: Int) -> Section<T> {
        return dataSource.sectionAtIndex(index)
    }
    
    public func sectionAtIndex(index: Int) -> SectionType {
        return dataSource.sectionAtIndex(index)
    }
}