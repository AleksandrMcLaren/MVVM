//
//  UIButton+Extension.swift
//  MVVM
//
//  Created by Aleksandr on 1/24/26.
//

import UIKit

extension UIButton {
    var isGreetingEnabled: Bool {
        get {
            return isEnabled
        }
        set {
            isEnabled = newValue
            alpha = isEnabled ? 1.0 : 0.95
        }
    }
}
