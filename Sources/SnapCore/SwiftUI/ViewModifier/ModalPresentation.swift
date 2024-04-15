//
//  ModalPresentation.swift
//  SnapCore
//
//  Created by Simon Nickel on 05.09.23.
//

import SwiftUI


// MARK: - View Modifier

public extension View {
	
	/// Presents a sheet or inspector when a binding to a Boolean value that you provide is true. This basically is a wrapper around .sheet and .inspector, to easier control presentation styles.
	/// - Parameters:
	///   - style: Preferred `ModalPresentationStyle`
	///   - isPresented: A binding to a Boolean value that determines whether to present the view that you create in the modifier’s content closure.
	///   - onDismiss: The closure to execute when dismissing the sheet. Only used for `ModalPresentationStyle.sheet`.
	///   - content: A closure that returns the content of the sheet.
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
	
	/// Uses .sheet on iPhone and .inspector for all other plattforms.
	/// While inspector appears as sheet on iPhone, it behaves a bit different (e.g. background). It will still appear as sheet on iPad in compact size class.
	/// TODO SwiftUI-limits: Be careful: inspector style will switch to sheet on size class changes, but does behave differently. Consider using .automaticFixed instead.
	case automaticDevice
	
	/// Uses .sheet on iPhone and iPad in compact size class, .inspector otherwise. Maintains style on sizeClass change while open.
	/// TODO SwiftUI-limits: Is preferred over .automatic as long as .inspector behaviour in sheet mode is different than normal sheets.
	case automaticFixed
	
	/// Present as .sheet(), displays as bottom sheet on small screens only.
	case sheet
	
	/// Present as .inspector(), displays as sheet on small screens.
	///
	/// TODO SwiftUI-limits:  Be careful, .inspector has so unexpected differences when presenting as sheet.
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
