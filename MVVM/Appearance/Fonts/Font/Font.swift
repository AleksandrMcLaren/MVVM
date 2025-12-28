//
//  Font.swift
//  MVVM
//
//  Created by Aleksandr on 12/27/25.
//

import UIKit

final class Font {
    enum FontType {
        enum Raleway: String {
            case semiBold = "Raleway-SemiBold"
        }
        enum SFProDisplay: String {
            case regular = "SFProDisplay-Regular"
        }
    }
    
    class func raleway(_ name: FontType.Raleway, size: CGFloat) -> UIFont {
        font(name.rawValue, size: size)
    }
    
    class func sfProDisplay(_ name: FontType.SFProDisplay, size: CGFloat) -> UIFont {
        font(name.rawValue, size: size)
    }
    
    private class func font(_ name: String, size: CGFloat) -> UIFont {
        //let list = UIFont.familyNames
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
