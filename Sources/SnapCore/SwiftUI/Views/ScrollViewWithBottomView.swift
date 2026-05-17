//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

// TODO cleanup: Could be a package of its own.

import SnapFoundation
import SwiftUI

// TODO macOS: BottomBackground does not appear when content is behind it.

/// A scroll view with a view pinned to the bottom of the visible area.
///
/// The bottom view is displayed as an overlay when content overflows, with `bottomBackground` shown behind it.
/// When the keyboard is visible and content overflows, the bottom view can optionally move inline into the
/// scroll content to keep it accessible above the keyboard.
public struct ScrollViewWithBottomView<Content: View, Bottom: View, BottomBackground: View>: View {
	
	public typealias ContentFactory = () -> Content
	@ViewBuilder private let content: ContentFactory
	public typealias BottomFactory = () -> Bottom
	@ViewBuilder private let bottom: BottomFactory
	public typealias BottomBackgroundFactory  = () -> BottomBackground
	private let bottomBackground: BottomBackgroundFactory
	
	private let embedBottomOnOverflowWithKeyboard: Bool
	
	/// - Parameter embedBottomOnOverflowWithKeyboard: When `true` (default), moves the bottom view inline
	///   into the scroll content while the keyboard is shown and content overflows, keeping it visible above the keyboard.
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
