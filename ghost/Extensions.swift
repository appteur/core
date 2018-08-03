//
//  Extensions.swift
//  ghost
//
//  Created by Tomáš Pánik on 28/07/2018.
//  Copyright © 2018 Tomáš Pánik. All rights reserved.
//

import Foundation
import UIKit

// localization
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self) }}

// color theme
extension UIColor {
    static let native = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0) }

// search bar
extension Library: UISearchBarDelegate { // delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContent(searchBar.text!) }}
extension Library: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { // updating
        _ = searchController.searchBar
        filterContent(searchController.searchBar.text!) }}
