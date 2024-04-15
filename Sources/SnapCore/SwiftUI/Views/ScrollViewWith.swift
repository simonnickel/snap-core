//
//  ScrollViewWith.swift
//  SnapCore
//
//  Created by Simon Nickel on 14.01.24.
//

import SwiftUI

public struct ScrollViewWith<Content: View>: View {
	
	public var hasOverflow: Binding<Bool>?
	
	/// A ScrollView that provides some insights into the size of its content.
	/// - Parameters:
	///   - hasOverflow: A `Binding<Bool>` that shows if the `Content` is larger than the `ScrollViews` bounds. Gets updated when the dimensions of the `ScrollView` or it's `Content` changes
	///   - content: <#content description#>
	public init(hasOverflow: Binding<Bool>? = nil, content: @escaping () -> Content) {
		self.hasOverflow = hasOverflow
		self.content = content
	}
	
	@ViewBuilder public let content: () -> Content
	
	@State private var sizeOfBounds: CGSize = .zero
	@State private var sizeOfContent: CGSize = .zero
	
	private func didUpdate() {
		hasOverflow?.wrappedValue = sizeOfContent.height > sizeOfBounds.height || sizeOfContent.width > sizeOfBounds.width
	}
	
	public var body: some View {
		
		ScrollView {
			
			content()
				.background {
					GeometryReader { geometry in
						Color.clear
							.onChange(of: geometry.size, initial: true) { oldValue, newValue in
								sizeOfContent = newValue
							}
					}
				}
			
		}
		.background {
			GeometryReader { geometry in
				Color.clear
					.onChange(of: geometry.size, initial: true) { oldValue, newValue in
						sizeOfBounds = newValue
					}
			}
		}
		.onChange(of: sizeOfBounds, initial: true) { oldValue, newValue in
			didUpdate()
		}
		.onChange(of: sizeOfContent, initial: true) { oldValue, newValue in
			didUpdate()
		}
		
	}
	
}


// MARK: - Preview

#Preview {
	
	struct ContainerView: View {
		
		@State var hasOverflow: Bool = false
		
		@State private var height: CGFloat = 500
		
		var body: some View {
			
			ScrollViewWith(hasOverflow: $hasOverflow) {
				VStack {
					Text("Has Overflow: \(hasOverflow.description)")
					HStack {
						Button {
							height -= 1
						} label: {
							Text("-1")
						}
						Button {
							height += 1
						} label: {
							Text("+1")
						}
					}
					HStack {
						Button {
							height -= 10
						} label: {
							Text("-10")
						}
						Button {
							height += 10
						} label: {
							Text("+10")
						}
					}
					HStack {
						Button {
							height -= 100
						} label: {
							Text("-100")
						}
						Button {
							height += 100
						} label: {
							Text("+100")
						}
					}

					Rectangle()
						.frame(height: height)
						.scenePadding()
				}
				.buttonStyle(BorderedButtonStyle())
			}
			.scrollBounceBehavior(.basedOnSize)
			
		}
	}
	
	return ContainerView()
	
}
