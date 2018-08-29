//
//  PrepareForClosure.swift
//  Todo
//
//  Created by Lyle Resnick on 2018-08-29.
//  Copyright © 2018 Lyle Resnick. All rights reserved.
//

import UIKit

typealias PrepareForSegueClosure = (UIStoryboardSegue) -> ()

protocol Segue {
    var rawValue: String { get }
}

extension UIViewController {
    func performSegue(identifier: Segue, sender: Any? = nil) {
        performSegue(withIdentifier: identifier.rawValue, sender: nil)
    }
}
