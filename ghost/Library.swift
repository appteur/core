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
    
    var detail: Detail? = nil
    var list = [GhostSection]()
    var filter = [ghost]()
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // search bar
        search.searchResultsUpdater = self as UISearchResultsUpdating
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "search".localized
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
        definesPresentationContext = true
        
        var list = [
            GhostSection(title: "a", items: [ghost(name:"an".localized, sort:"sort.an".localized, id:"0101")]),
            GhostSection(title: "b", items: [ghost(name:"bc".localized, sort:"sort.bc".localized, id:"0102")]),
            GhostSection(title: "c", items: [ghost(name:"cd".localized, sort:"sort.cd".localized, id:"0103")])
        ]
        sort()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selection = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selection, animated: animated)
        }
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // sections
    class GhostSection {
        var sectionTitle: String
        var items: [ghost] = []
        
        init(title: String, items: [ghost]) {
            sectionTitle = title
            self.items = items
        }
    }

    // chceck this IDK I've done it well
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtering() {
            return filter.count
        }
        return list[section].items.count // <-
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "library", for: indexPath)
        var data = list[indexPath.section].items[indexPath.row] // <-
        if filtering() {
            data = filter[indexPath.row] // <-
        } else {
            data = list[indexPath.section].items[indexPath.row]
        }

        cell.textLabel?.text = data.name
        return cell
    }
    
    // table sorting
    func sort() {
        list.items.sort(by: {$0.sort < $1.sort})
        self.tableView.reloadData()
    }
    
    // segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transporter" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selected: ghost
                if filtering() {
                    selected = filter[indexPath.row]
                } else {
                    selected = list[indexPath.row]
                }
                let controller = (segue.destination as! Detail)
                controller.result = selected }}}
    
    // filter
    func filterContent(_ searchText: String) {
        filter = list.filter({(data : ghost) -> Bool in
            if searchEmpty() {
                return true
            } else {
                return true && data.name.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    func searchEmpty() -> Bool {
        return search.searchBar.text?.isEmpty ?? true
    }
    func filtering() -> Bool {
        return search.isActive && (!searchEmpty())
    }

}

