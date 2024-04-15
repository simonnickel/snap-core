//
//  CGFloat+Rounding.swift
//  SnapCore
//
//  Created by Simon Nickel on 20.03.23.
//

import Foundation

public extension CGFloat {
	
	func round(decimals: UInt, rule: FloatingPointRoundingRule = .toNearestOrEven) -> CGFloat {
		let multiplier = CGFloat(NSDecimalNumber(decimal: pow(10, Int(decimals))).doubleValue)
		return (self * multiplier).rounded(rule) / multiplier
	}
	
}
