# RealmDataSource

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Provides [Realm](https://realm.io) extensions for the [DataSource](https://github.com/mbuchetics/DataSource) framework.

## Platform

iOS 8.0+, Swift 2

## Usage

An example app is included demonstrating RealmDataSource's functionality showing how a realm query can be used as a table's data source.

### Getting Started

Setup your queries:

```swift
let realm = try! Realm()
let personsB = realm.objects(Person).filter("lastName BEGINSWITH 'B'")
let personsM = realm.objects(Person).filter("lastName BEGINSWITH 'M'")
```

Use `RealmSection` instead of the `Section` and set your results:

```swift    
let dataSource = DataSource([
    RealmSection(title: "B", rowIdentifier: Identifiers.PersonCell.rawValue, results: personsB),
    RealmSection(title: "M", rowIdentifier: Identifiers.PersonCell.rawValue, results: personsM)
])
```

Initialize your `TableViewDataSource` (see [DataSource](https://git.allaboutapps.at/projects/AAAIOS/repos/datasource/browse) for details):
    
```swift
tableDataSource = TableViewDataSource(
    dataSource: dataSource,
    configurator: TableViewCellConfigurator(Identifiers.PersonCell.rawValue) { (person: Person, cell: PersonCell, _) in
        cell.firstNameLabel?.text = person.firstName
        cell.lastNameLabel?.text = person.lastName
    })

tableView.dataSource = tableDataSource
tableView.reloadData()
```


## Installation

### Carthage

Add the following line to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

```
github "mbuchetics/RealmDataSource", ~> 1.0
```

Then run `carthage update`.

### Manually

Just drag and drop the `.swift` files in the `RealmDataSource` folder into your project.

## License

`DataSource` is available under the MIT license. See the [LICENSE](https://github.com/mbuchetics/DataSource/blob/master/LICENSE.md) file for details.

## Contact

Contact me at [matthias.buchetics.com](http://matthias.buchetics.com) or follow me on [Twitter](https://twitter.com/mbuchetics).

Made with ❤ at [all about apps](https://www.allaboutapps.at).

[<img src="https://github.com/mbuchetics/DataSource/blob/master/Resources/aaa_logo.png" height="60" alt="all about apps" />](https://www.allaboutapps.at)
