//
//  fetchSubString.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/20.
//  Copyright © 2020 钱立新. All rights reserved.
//

import Foundation

// support fetching subString by subscribe
extension String {
    subscript (range: Range<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
