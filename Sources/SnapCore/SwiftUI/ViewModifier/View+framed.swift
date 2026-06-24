//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// Controls how a view sizes itself horizontally when wrapped via `.framed(_:)`.
public enum FrameWidth: String, Hashable, CaseIterable, Sendable {

    /// Expand to fill the available width.
    case fill

    /// Size to fit the content within an outer frame.
    case fit

    fileprivate var maxWidth: CGFloat? {
        switch self {
            case .fill: .infinity
            case .fit: nil
        }
    }
}


// MARK: - Modifier

extension View {

    /// Wraps the view in a `.frame` whose `maxWidth` is driven by `width`.
    /// `.fill` produces `maxWidth: .infinity`, `.fit` produces `maxWidth: nil`.
    public func framed(
        _ width: FrameWidth = .fill,
        alignment: Alignment = .leading,
    ) -> some View {
        frame(maxWidth: width.maxWidth, alignment: alignment)
    }
}


// MARK: - Preview

#Preview {
    @Previewable @State var width: FrameWidth = .fill
    
    VStack(spacing: 24) {
        Text("Content")
            .padding()
            .background(Color.accentColor.opacity(0.5))
            .framed(width)
            .background(.gray.opacity(0.2))
        
        Picker("Width", selection: $width.animation()) {
            ForEach(FrameWidth.allCases, id: \.self) { value in
                Text(value.rawValue).tag(value)
            }
        }
        .pickerStyle(.segmented)
    }
    .padding()
}
