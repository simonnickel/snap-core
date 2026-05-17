//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SwiftUI


// MARK: - View Modifier

public extension View {
	
	/// Presents a sheet or inspector depending on the given `ModalPresentationStyle`.
	/// - Parameters:
	///   - style: The presentation style to use.
	///   - isPresented: A binding to a Boolean value that determines whether to present the view.
	///   - onDismiss: Called when the modal is dismissed. Only invoked for `.sheet` style.
	///   - content: A closure that returns the content of the modal.
	func modalPresentation<Content>(style: ModalPresentationStyle, isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
		
		self.modifier(
			ModalPresentation(
				style: style,
				isPresented: isPresented,
				onDismiss: onDismiss,
				contentBuilder: content
			)
		)
		
	}

}

public enum ModalPresentationStyle: String, CaseIterable, Identifiable {
	public var id: String { rawValue}
	
	/// Uses `.sheet` on iPhone, `.inspector` on all other platforms.
	/// Does not lock the style when the modal opens — prefer ``automaticFixed`` to avoid
	/// inconsistent behaviour if the size class changes while the modal is open.
	/// - Note: SwiftUI limitation: inspector will switch to a sheet on size class changes but behaves differently than a normal sheet.
	case automaticDevice

	/// Uses `.sheet` on iPhone and iPad in compact size class, `.inspector` otherwise.
	/// Locks the style at the time of presentation, maintaining it across size class changes.
	/// - Note: SwiftUI limitation: preferred over ``automaticDevice`` as long as `.inspector` behaves differently than `.sheet` when presented as one.
	case automaticFixed

	/// Always presents as a sheet.
	case sheet

	/// Always presents as an inspector panel. Falls back to a sheet on compact size classes,
	/// but with subtle behavioural differences from `.sheet`.
	/// - Note: SwiftUI limitation: `.inspector` has unexpected differences when presenting as a sheet.
	case inspector
	
}

private struct ModalPresentation: ViewModifier {
	
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	let style: ModalPresentationStyle
	var isPresented: Binding<Bool>
	let onDismiss: (() -> Void)?
	let contentBuilder: () -> any View

	@State private var sizeClassOnOpen: UserInterfaceSizeClass?
	
	/// Determine actual style for presentation.
	private static func style(for style: ModalPresentationStyle, sizeClass: UserInterfaceSizeClass) -> ModalPresentationStyle {
		switch style {
				
			case .automaticDevice:
#if canImport(UIKit)
				switch UIScreen.main.traitCollection.userInterfaceIdiom {
					case .phone: .sheet
					default: .inspector
				}
#else
					.inspector
#endif
				
			case .automaticFixed:
#if canImport(UIKit)
				switch UIScreen.main.traitCollection.userInterfaceIdiom {
					case .phone: .sheet
						// TODO SwiftUI-limits: .inspector does automatically switch to a sheet, but behaves different. This causes issues when switching from .regular to .compact size class.
					default: sizeClass == .compact ? .sheet : .inspector
				}
#else
					.inspector
#endif
				
			default: style
		}
	}
	
	public func body(content: Content) -> some View {
		let styleActual = ModalPresentation.style(for: style, sizeClass: sizeClassOnOpen ?? .regular)
		return content
			.if(styleActual == .sheet, transform: { view in
				view.sheet(isPresented: isPresented, onDismiss: onDismiss, content: {
					AnyView(contentBuilder())
				})
			})
			.if(styleActual == .inspector, transform: { view in
				view.inspector(isPresented: isPresented, content: {
					AnyView(contentBuilder())
				})
			})
			.if(style == .automaticFixed, transform: { view in
				// Update sizeClassOnOpen when presentation starts, to maintain style on size class changes.
				view.onChange(of: isPresented.wrappedValue, initial: true) { oldValue, newValue in
						switch newValue {
							case false: sizeClassOnOpen = nil
							case true: if sizeClassOnOpen == nil {
								sizeClassOnOpen = horizontalSizeClass
							}
						}
					}
			})
	}
	
}


// MARK: - Previews

#Preview {
	
	struct Container: View {
		
		@State var selectedStyle: ModalPresentationStyle = .sheet
		@State var isPresented: Bool = false
		
		var body: some View {
			VStack {
				
				Picker(selection: $selectedStyle) {
					ForEach(ModalPresentationStyle.allCases) { style in
						Text(style.rawValue).tag(style)
					}
				} label: {
					Text("Label")
				}
				.pickerStyle(.segmented)

				Toggle(isOn: $isPresented) {
					Text("Show Modal")
				}
				
			}
			.scenePadding()
			.modalPresentation(style: selectedStyle, isPresented: $isPresented, content: {
				AnyView(Text("Modal"))
			})
		}
	}
	
	return Container()
}
