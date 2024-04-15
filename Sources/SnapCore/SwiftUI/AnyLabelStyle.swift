//
//  AnyLabelStyle.swift
//  SnapCore
//
//  Created by Simon Nickel on 25.09.23.
//

import SwiftUI

public struct AnyLabelStyle: LabelStyle {
	
	private let bodyBuilder: (Configuration) -> AnyView
	
	public init(_ base: some LabelStyle) {
		self.bodyBuilder = { AnyView(base.makeBody(configuration: $0)) }
	}
	
	public func makeBody(configuration: Configuration) -> some View {
		bodyBuilder(configuration)
	}
	
}
