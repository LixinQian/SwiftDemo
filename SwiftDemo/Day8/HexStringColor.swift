//
//  HexStringColor.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/20.
//  Copyright © 2020 钱立新. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    ///  Translate Hex String to UIColor, support following formats:
    ///  "00ffff", "#00ffff", "0x00ffff"
    ///
    func toUIColor() -> UIColor {
        
        guard (hasPrefix("#") && count == 7) ||
            (hasPrefix("0x") && count == 8) ||
            (count == 6) else {
                return UIColor.red
        }
        
        var origin = self
        
        if (self.hasPrefix("#")) {
            origin = origin[1..<count]
        } else if (self.hasPrefix("0x")) {
            origin = origin[2..<count]
        }
        
        var red: UInt64 = 0, green: UInt64 = 0, blue: UInt64 = 0
        Scanner(string: origin[0..<2]).scanHexInt64(&red)
        Scanner(string: origin[2..<4]).scanHexInt64(&green)
        Scanner(string: origin[4..<6]).scanHexInt64(&blue)
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
