//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var controlState: ViewControlState = .active
}

/// Represents the interactivity state of a control.
///
/// Use `.controlState(_:)` to propagate this value via the environment and apply the
/// corresponding enabled/disabled state. Consumers can read `\.controlState` from the
/// environment to render a distinct visual state per case.
public enum ViewControlState: String, CaseIterable {

    /// The view is enabled and interactable.
    case active
    /// The view is enabled but semantically inactive (e.g. a submit button before required fields are filled).
    case inactive
    /// The view is disabled and not interactable.
    case disabled

    var isEnabled: Bool {
        switch self {
            case .active, .inactive: return true
            case .disabled: return false
        }
    }
}

extension View {
    /// Sets the `ViewControlState` in the environment and applies `.enabled()` based on `state.isEnabled`.
    public func controlState(_ state: ViewControlState) -> some View {
        self
            .environment(\.controlState, state)
            .enabled(state.isEnabled)
    }
}


// MARK: - Preview

#Preview {
    
    struct StatusButton: View {
        @Environment(\.controlState) private var controlState
        
        private var indicator: Color {
            switch controlState {
                case .active: return .green
                case .inactive: return .red
                case .disabled: return .gray
            }
        }
        var body: some View {
            Button {} label: {
                Label {
                    Text("Button")
                } icon: {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(indicator)
                }
            }
        }
    }
    
    return VStack {
        StatusButton()
            .controlState(.active)
        StatusButton()
            .controlState(.inactive)
        StatusButton()
            .controlState(.disabled)
        StatusButton()
            .enabled(false)
    }
    .padding()
}
