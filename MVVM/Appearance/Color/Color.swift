//
//  Color.swift
//  MVVM
//
//  Created by Aleksandr on 12/27/25.
//

import UIKit

final class Color {
    private static let shared = Color()
    
    private var scheme = LightScheme()
}

extension Color {
    class var background: UIColor {
        return Color.shared.scheme.background
    }
    class var title: UIColor {
        return Color.shared.scheme.title
    }
    class var button: UIColor {
        return Color.shared.scheme.button
    }
}

protocol ColorThemeProtocol {
    var background: UIColor { get }
    var title: UIColor { get }
    var button: UIColor { get }
}

struct LightScheme: ColorThemeProtocol {
    let background: UIColor = UIColor(red: 0.58, green: 0.82, blue: 0.74, alpha: 1.00)
    let title = UIColor(red: 0.00, green: 0.07, blue: 0.10, alpha: 1.00)
    let button = UIColor(red: 0.04, green: 0.58, blue: 0.59, alpha: 1.00)
}


