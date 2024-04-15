//
//  EdgeInsets+Helper.swift
//  SnapCore
//
//  Created by Simon Nickel on 23.03.23.
//

import SwiftUI

public extension EdgeInsets {
	
	init(all value: CGFloat) {
		self.init(top: value, leading: value, bottom: value, trailing: value)
	}
	
	init(horizontal: CGFloat, vertical: CGFloat) {
		self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
	}
	
	static var zero: EdgeInsets { .init(all: 0) }
	
}
