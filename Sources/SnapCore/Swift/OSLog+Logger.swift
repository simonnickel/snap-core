//
//  OSLog+Logger.swift
//	SnapCore
//
//  Created by Simon Nickel on 25.02.24.
//

import Foundation
import OSLog

public extension Logger {
	
	/// Custom init with `bundleIdentifier` as subsystem.
	init(category: String) {
		let subsystem = Bundle.main.bundleIdentifier!
		self.init(subsystem: subsystem, category: category)
	}
	
	/// Custom init with `bundleIdentifier` as subsystem and the given `type` as category.
	/// - Parameter type: The type to use as category.
	init<T>(forType type: T.Type) {
		let subsystem = Bundle.main.bundleIdentifier!
		let category = String(describing: type)
		self.init(subsystem: subsystem, category: category)
	}
	
}
