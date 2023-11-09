//
//  AlwaysFalseAutoresizing.swift
//  Tracker
//
//  Created by Kirill Gontsov on 06.11.2023.
//

import UIKit

extension UIView {
    func falseAutoresizing(_ view: UIView){
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
