//
//  ListHeaderView.swift
//  UIWidgetKit
//
//  Created by Seth on 7/11/18.
//  Copyright © 2018 aii. All rights reserved.
//

import UIKit

open class ListHeaderView: UIView {

    @IBOutlet weak public  var titleLabel: UILabel!
    
    open override func awakeFromNib() {
        // default ui configurations
        layer.masksToBounds = true
    }
}
