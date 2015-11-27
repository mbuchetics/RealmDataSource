//
//  RealmTableViewController.swift
//  RealmDataSource
//
//  Created by Matthias Buchetics on 27/11/15.
//  Copyright © 2015 all about apps GmbH. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import DataSource
import RealmDataSource

enum Identifiers: String {
    case PersonCell
}

class RealmTableViewController: UITableViewController {
    var tableDataSource: TableViewDataSource!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRealm()
        setupDataSource()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.dataSource = tableDataSource
        tableView.reloadData()
        
        print(NameGenerator.firstName)
        print(NameGenerator.lastName)
    }
    
    var persons: Results<Person> {
        return realm.objects(Person)
    }
    
    func setupRealm() {
        var persons = Array<Person>()
        
        for _ in 0..<100 {
            let p = Person(firstName: NameGenerator.firstName, lastName: NameGenerator.lastName)
            persons.append(p)
        }
        
        try! realm.write {
            self.realm.deleteAll()
            self.realm.add(persons)
        }
    }
    
    func setupDataSource() {
        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        let sections = letters.map { letter -> SectionType in
            let query = persons.filter("lastName BEGINSWITH '\(letter)'")
            return RealmSection(title: "B", rowIdentifier: Identifiers.PersonCell.rawValue, results: query)
        }
        
        let dataSource = DataSource(sections)
        
        tableDataSource = TableViewDataSource(
            dataSource: dataSource,
            configurator: TableViewCellConfigurator(Identifiers.PersonCell.rawValue) { (person: Person, cell: PersonCell, _) in
                cell.firstNameLabel?.text = person.firstName
                cell.lastNameLabel?.text = person.lastName
            })
        
        debugPrint(dataSource)
    }
}
