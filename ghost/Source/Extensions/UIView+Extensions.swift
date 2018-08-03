//
//  UIView+Extensions.swift
//  ghost
//
//  Created by Seth on 8/3/18.
//

import UIKit

public extension UIView {
    
    public static func fromNib() -> UIView? {
        let nibName = String(describing: self)
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            print("Unable to instantiate nib named: \(nibName) in bundle: \(String(describing: bundle)) -- nib: \(String(describing: nib))")
            return nil
        }
        return view
    }
}
