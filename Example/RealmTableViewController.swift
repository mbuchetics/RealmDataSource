//
//  RealmTableViewController.swift
//  RealmDataSource
//
//  Created by Matthias Buchetics on 27/11/15.
//  Copyright © 2015 all about apps GmbH. All rights reserved.
//

import UIKit
import RealmSwift
import DataSource
import RealmDataSource

enum Identifiers: String {
    case PersonCell
}

class RealmTableViewController: UITableViewController {
    var tableDataSource: TableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRealm()
        setupDataSource()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.dataSource = tableDataSource
        tableView.reloadData()
    }
    
    func setupRealm() {
        let persons = [
            Person(firstName: "Matthias", lastName: "Buchetics"),
            Person(firstName: "Hugo", lastName: "Maier"),
            Person(firstName: "Max", lastName: "Mustermann")
        ]
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            realm.add(persons)
        }
    }
    
    func setupDataSource() {
        let realm = try! Realm()
        let personsB = realm.objects(Person).filter("lastName BEGINSWITH 'B'")
        let personsM = realm.objects(Person).filter("lastName BEGINSWITH 'M'")
        
        let dataSource = DataSource([
            RealmSection(title: "B", rowIdentifier: Identifiers.PersonCell.rawValue, results: personsB),
            RealmSection(title: "M", rowIdentifier: Identifiers.PersonCell.rawValue, results: personsM)
        ])
        
        tableDataSource = TableViewDataSource(
            dataSource: dataSource,
            configurator: TableViewCellConfigurator(Identifiers.PersonCell.rawValue) { (person: Person, cell: PersonCell, _) in
                cell.firstNameLabel?.text = person.firstName
                cell.lastNameLabel?.text = person.lastName
            })
        
        debugPrint(dataSource)
    }
}
