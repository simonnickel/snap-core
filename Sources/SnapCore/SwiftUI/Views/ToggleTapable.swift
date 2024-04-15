//
//  ToggleTapable.swift
//  SnapCore
//
//  Created by Simon Nickel on 26.09.23.
//

import SwiftUI

/// Wrapper for Toggle to allow tapping the label for activation.
///
///	- FB13208258: Toggle should be activated when label is tapped. Should have same behaviour as Picker.
public struct ToggleTapable<Label: View>: View {
	
	public init(isOn: Binding<Bool>, label: @escaping () -> Label) {
		self.isOnExternal = isOn
		self.label = label
		
		_isOn = State(initialValue: isOn.wrappedValue)
	}
	
	/// Toggle() seems to need an actual State var to be tapable, directly assigning a binding can cause issues.
	private var isOnExternal: Binding<Bool>
	
	private let label: () -> Label
	
	@State private var isOn: Bool
	
	public var body: some View {
		
		Toggle(isOn: $isOn, label: label)
		// FB13208258: Toggle should be activated when label is tapped. Should have same behaviour as Picker.
			.contentShape(Rectangle())
			.onTapGesture {
				isOn.toggle()
			}
			.onChange(of: isOn) { oldValue, newValue in
				if isOnExternal.wrappedValue != newValue {
					isOnExternal.wrappedValue = newValue
				}
			}
			.onChange(of: isOnExternal.wrappedValue) { oldValue, newValue in
				if isOn != newValue {
					isOn = newValue
				}
			}
		
	}
	
}


// MARK: - Preview

#Preview {
	
	VStack {
		
		Toggle(isOn: .constant(true)) {
			Label("Always on", systemImage: "star")
		}
		Toggle(isOn: .constant(false)) {
			Label("Always off", systemImage: "star")
		}
		ToggleTapable(isOn: .constant(true)) {
			Label("ToggleTapable always on", systemImage: "star")
		}
		
	}
	
}

