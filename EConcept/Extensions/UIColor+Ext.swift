//
//  UIColor+Ext.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import UIKit

extension UIColor {
    
    static let backThemeColor = UIColor(named: "backThemeColor")
    static let highlightThemeColor = UIColor(named: "highlightThemeColor")
    static let backgroundThemeColor = UIColor(named: "backgroundThemeColor")
    static let lineThemeColor = UIColor(named: "lineThemeColor")
    static let backButtonThemeColor = UIColor(named: "backButtonThemeColor")
    static let starThemeColor = UIColor(named: "starThemeColor")
    static let grayThemeColor = UIColor(named: "grayThemeColor")
    static let iconThemeColor = UIColor(named: "iconThemeColor")
    static let bevelThemeColor = UIColor(named: "bevelThemeColor")
    
    /// Init with separate Int colors
    /// - Parameters:
    ///   - red: red Int value
    ///   - green: green Int value
    ///   - blue: blue Int value
    convenience init(red: Int, green: Int, blue: Int) {
        
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
    /// Init with RGB as Integer number
    /// - Parameter rgb: Integer number (ex. 0xFFFFFF)
    convenience init(rgb: Int) {
        
        self.init(red: (rgb >> 16) & 0xFF,
                  green: (rgb >> 8) & 0xFF,
                  blue: rgb & 0xFF)
    }
    
    /// Init with RGB string
    /// - Parameter rgbHex: RGB string (ex. #FFFFFF)
    convenience init(rgbHex: String) {
        
        var digitalString: String = rgbHex
        digitalString.removeFirst()
        let digital: Int = Int(digitalString, radix: 16) ?? 0
        
        self.init(rgb: digital)
    }
}
