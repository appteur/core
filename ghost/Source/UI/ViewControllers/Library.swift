//
//  Library.swift
//  ghost
//
//  Created by Tomáš Pánik on 28/07/2018.
//  Copyright © 2018 Tomáš Pánik. All rights reserved.
//

import UIKit

class Library: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    let search = UISearchController(searchResultsController: nil)
    var detail: Detail? = nil
    var list = [
        GhostSection(title: "a", items: [
            Ghost(name:"am".localized, sort:"sort.am".localized, id:"0101"),
            Ghost(name:"an".localized, sort:"sort.an".localized, id:"0101"),
            Ghost(name:"co".localized, sort:"sort.co".localized, id:"0101"),
            Ghost(name:"cp".localized, sort:"sort.cp".localized, id:"0101")
            ]),
        GhostSection(title: "b", items: [
            Ghost(name:"bc".localized, sort:"sort.bc".localized, id:"0102"),
            Ghost(name:"br".localized, sort:"sort.br".localized, id:"0102"),
            Ghost(name:"bt".localized, sort:"sort.bt".localized, id:"0102"),
            Ghost(name:"bo".localized, sort:"sort.bo".localized, id:"0102"),
            Ghost(name:"by".localized, sort:"sort.by".localized, id:"0102")
            ]),
        GhostSection(title: "c", items: [
            Ghost(name:"cc".localized, sort:"sort.cc".localized, id:"0103"),
            Ghost(name:"cd".localized, sort:"sort.cd".localized, id:"0103"),
            Ghost(name:"dd".localized, sort:"sort.dd".localized, id:"0103"),
            Ghost(name:"ck".localized, sort:"sort.ck".localized, id:"0103"),
            Ghost(name:"ct".localized, sort:"sort.ct".localized, id:"0103"),
            Ghost(name:"cm".localized, sort:"sort.cm".localized, id:"0103"),
            Ghost(name:"pp".localized, sort:"sort.pp".localized, id:"0103")
            ])
    ]
    
    // when filtering, filtered section results will be placed in this array
    var filter = [GhostSection]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // setup dynamic cell height
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        
        // if these are not set the header/footer delegate functions will not be called.
        tableView.estimatedSectionHeaderHeight = 50.0
        tableView.estimatedSectionFooterHeight = 50.0
        
        // search bar
        search.searchResultsUpdater = self as UISearchResultsUpdating
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "search".localized
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
        definesPresentationContext = true
        
        sort()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selection = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selection, animated: animated)
        }
        super.viewWillAppear(animated)
    }
    

    // chceck this IDK I've done it well
    func numberOfSections(in tableView: UITableView) -> Int {
        return filtering() ? filter.count : list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // if we're filtering, return the filter count, else the list count
        let section = filtering() ? filter[section] : list[section]
        
        // if we're filtering, return the section filter count, else the section items count
        return filtering() ? section.filter.count : section.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get the cell for this index path
        let cell = tableView.dequeueReusableCell(withIdentifier: "library", for: indexPath)
        
        // get the data for this sections cell
        let data = ghostItem(for: indexPath)

        // update cell title label
        cell.textLabel?.text = data.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // this loads the view from the nib
        guard let view = ListHeaderView.fromNib() as? ListHeaderView else {
            return nil
        }
        
        // get the section object for the current section
        let data = filtering() ? filter[section] : list[section]
        
        // and set the title label text here from our section object
        view.titleLabel.text = data.sectionTitle
        return view
    }
    
    // if you want to also have a custom footer you can do that here...
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // and let the header height be dynamic, or return a set height here...
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // table sorting
    func sort() {
        
        // sort each list in each section
        list.forEach({ $0.sort() })
        
        // reload the table
        tableView.reloadData()
    }
    
    
    /// Convenience function for getting the current item for the current indexPath
    ///
    /// - Parameter indexPath: The index path for the requested item
    /// - Returns: The Ghost object corresponding to the row in the requested section
    func ghostItem(for indexPath: IndexPath) -> Ghost {
        
        if filtering() {
            // grab from the filtered results if we're filtering
            let section = filter[indexPath.section]
            return section.filter[indexPath.row]
        } else {
            // grab from the regular list if we're not filtering
            let section = list[indexPath.section]
            return section.items[indexPath.row]
        }
    }
    
    // segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transporter" {
            if let indexPath = tableView.indexPathForSelectedRow, let controller = segue.destination as? Detail {
                let selected = ghostItem(for: indexPath)
                controller.result = selected
            }
        }
    }
    
    // filter
    func filterContent(_ searchText: String) {
        
        // have each section filter its own content
        list.forEach({ $0.filter(searchText) })
        
        // remove sections that have no search results
        filter = list.filter({ $0.filter.count > 0 })
        
        // update tableview
        tableView.reloadData()
    }
    
    func searchEmpty() -> Bool {
        return search.searchBar.text?.isEmpty ?? true
    }
    func filtering() -> Bool {
        return search.isActive && (!searchEmpty())
    }

}

