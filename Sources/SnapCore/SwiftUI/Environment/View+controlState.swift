//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var controlState: ViewControlState = .active
}

public enum ViewControlState: String {
    
    case disabled, inactive, active
    
    var isEnabled: Bool {
        switch self {
            case .active, .inactive: return true
            case .disabled: return false
        }
    }
}

extension View {
    /// Provide the `ViewControlState` via Environment and sets `.enabled()` to value of provided `state.isEnabled`.
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
