//
//  View+KeyboardPublisher.swift
//  SnapCore
//
//  Created by Simon Nickel on 15.01.24.
//

import SwiftUI
import Combine

public extension View {
	
#if !os(macOS)
	
	/// A publisher that updates on changes to keyboard visibility.
	///
	/// Uses `UIResponder.keyboardWillShowNotification` and `UIResponder.keyboardWillHideNotification`.
	///
	///	How to use:
	/// ```
	/// .onReceive(keyboardPublisher, perform: { isPresented in
	///		self.keyboardIsVisible = isPresented
	///	})
	/// ```
	var keyboardPublisher: AnyPublisher<Bool, Never> {
		Publishers
			.Merge(
				NotificationCenter
					.default
					.publisher(for: UIResponder.keyboardWillShowNotification)
					.map { _ in true },
				
				NotificationCenter
					.default
					.publisher(for: UIResponder.keyboardWillHideNotification)
					.map { _ in false }
			)
		//			.debounce(for: .seconds(0.1), scheduler: RunLoop.main) // TODO finetuning: Consider adding optional debounce to reduce being callep on switching TextFields. Should be optional to allow getting notified immediately (necessary for some animations).
			.eraseToAnyPublisher()
	}
	
#endif
	
}
