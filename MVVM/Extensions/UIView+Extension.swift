//
//  UIView+Extension.swift
//  MVVM
//
//  Created by Aleksandr on 1/24/26.
//

import UIKit

extension UIView {
    func removeSubviewsAutoresizingMask() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
