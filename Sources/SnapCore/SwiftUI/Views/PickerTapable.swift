//
//  PickerTapable.swift
//  SnapCore
//
//  Created by Simon Nickel on 20.12.23.
//

import SwiftUI

/// Wrapper of Picker to include PickerStyle and fix some issues. See SnapTheme.ThemePickerListRow for a version with styling.
///
///	- FB13208225: setting the pickerStyle causes only the picker part to be tappable.
///	Workaround: Setting .pickerStyle() to .menu (instead of .automatic, which is .menu on iOS) causes only the picker part to be tappable.
///
///	- FB12181540: Should be able to apply color and font to Picker.
///	Workaround: None, see SnapTheme.ThemePickerListRow for a replacement.
public struct PickerTapable<Label, SelectionValue, Content> : View where Label : View, SelectionValue : Hashable, Content : View {
	
	public init(style: any PickerStyle = .automatic, selection: Binding<SelectionValue>, content: @escaping () -> Content, label: @escaping () -> Label) {
		self.style = style
		self.selection = selection
		self.content = content
		self.label = label
	}
	
	let style: any PickerStyle
	let selection: Binding<SelectionValue>
	let content: () -> Content
	let label: () -> Label
	
	public var body: some View {
		
		AnyView(
			Picker(selection: selection, content: content, label: {
				label()
					.frame(maxWidth: .infinity, alignment: .leading)
			})
				.pickerStyle(style)
		)
#if os(macOS) // TODO macOS: When the themes accent is set to .accentColor it crashes. Overriding it here fixes it, but will show wrong color.
			.tint(.accentColor)
#endif
		
	}
	
}
