//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

// TODO cleanup: Could be a package of its own.

import SnapFoundation
import SwiftUI

// TODO macOS: BottomBackground does not appear when content is behind it.

public struct ScrollViewWithBottomView<Content: View, Bottom: View, BottomBackground: View>: View {
	
	public typealias ContentFactory = () -> Content
	@ViewBuilder private let content: ContentFactory
	public typealias BottomFactory = () -> Bottom
	@ViewBuilder private let bottom: BottomFactory
	public typealias BottomBackgroundFactory  = () -> BottomBackground
	private let bottomBackground: BottomBackgroundFactory
	
	private let embedBottomOnOverflowWithKeyboard: Bool
	
	public init(@ViewBuilder content: @escaping ContentFactory, @ViewBuilder bottom: @escaping BottomFactory, bottomBackground: @escaping BottomBackgroundFactory, embedBottomOnOverflowWithKeyboard: Bool = true) {
		self.content = content
		self.bottom = bottom
		self.bottomBackground = bottomBackground
		self.embedBottomOnOverflowWithKeyboard = embedBottomOnOverflowWithKeyboard
	}
	
	@State private var embedBottom: Bool = false
	private var shouldEmbedBottom: Bool {
		embedBottomOnOverflowWithKeyboard && keyboardIsPresented && hasOverflow
	}
	
	@State private var hasOverflow: Bool = false
	@State private var showBottomBackground: Bool = false
	@State private var keyboardIsPresented: Bool = false
	@State private var isDuringKeyboardAppear: Bool = false
	@State private var shouldIgnoreKeyboardSafeArea: Bool = false
	
	@Namespace private var animationBottom
	@State private var geometryBottom: CGSize = .zero
	
	private func updateState(animated: Bool) {
		if animated {
			withAnimation {
				updateState()
			}
		} else {
			updateState()
		}
	}
	
	private func updateState() {
		embedBottom = shouldEmbedBottom
		showBottomBackground = hasOverflow
	}
	
	public var body: some View {
		
		let bottom = bottom()
			.matchedGeometryEffect(id: "Bottom", in: animationBottom)
			.transition(.identity)
		
		ZStack {
			
			ScrollViewWith(hasOverflow: $hasOverflow) {
				VStack {
					
					content()
					
					if embedBottom {
						bottom
					} else {
						Spacer().frame(height: geometryBottom.height)
					}
					
				}
			}
			
			VStack {
				Spacer()
				if !embedBottom {
					VStack {
						bottom
							.background { // This has to be applied before any sizes of change. It needs to fit the size of the Spacer thats displayed inline. Otherwise it will cause an infinite loop on resize, because content size changes to not show inline anymore.
								GeometryReader { geometry in
									Color.clear
										.onAppear {
											geometryBottom = geometry.size
										}
										.onChange(of: geometry.size) { oldSize, newSize in
											geometryBottom = newSize
										}
								}
							}
					}
					.background(showBottomBackground ? AnyView(bottomBackground()) : AnyView(Color.clear))
				}
			}
			.if(shouldIgnoreKeyboardSafeArea, transform: { view in
				view.ignoresSafeArea(.keyboard)
			})
			
		}
#if !os(macOS)
		.onReceive(keyboardPublisher, perform: { isPresented in
			if isPresented {
				isDuringKeyboardAppear = true
				DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
					isDuringKeyboardAppear = false
				}
			}
			keyboardIsPresented = isPresented
			shouldIgnoreKeyboardSafeArea = shouldEmbedBottom
			
			updateState(animated: true)
		})
#endif
		.onChange(of: hasOverflow) { oldValue, newValue in
			if isDuringKeyboardAppear {
				shouldIgnoreKeyboardSafeArea = shouldEmbedBottom
			}
			updateState(animated: newValue || isDuringKeyboardAppear)
		}
		.onChange(of: embedBottom) { oldValue, newValue in
			if isDuringKeyboardAppear {
				shouldIgnoreKeyboardSafeArea = false
			}
		}
		
	}
	
}


// MARK: Preview

#Preview {
	
	ScrollViewWithBottomView {
		Rectangle()
			.scenePadding()
			.frame(height: 100)
	} bottom: {
		Text("Bottom")
	} bottomBackground: {
		Rectangle().fill(Color.green)
	}
	
}
