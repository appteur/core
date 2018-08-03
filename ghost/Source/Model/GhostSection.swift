//
//  GhostSection.swift
//  ghost
//
//  Created by Seth on 8/3/18.
//

import Foundation

// sections
class GhostSection {
    
    var sectionTitle: String
    var items = [Ghost]()
    var filter = [Ghost]()
    
    init(title: String, items: [Ghost]) {
        sectionTitle = title
        self.items = items
    }
    
    func sort() {
        items.sort(by: { $0.sort < $1.sort })
    }
    
    func filter(_ searchText: String) {
        filter = items.filter({
            $0.name.lowercased().contains(searchText.lowercased())
        })
    }
}
