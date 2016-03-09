//
//  Extensions.swift
//  iconMaker
//
//  Created by Chen Yu-Chun on 2015/12/15.
//  Copyright © 2015年 Chen Yu-Chun. All rights reserved.
//

import Foundation

extension CGFloat {
    func string(fractionDigits:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.stringFromNumber(self) ?? "\(self)"
    }
}

