# SnapCore

A collection of useful helper implementations and common extensions for Swift and SwiftUI.

> This package is part of the [SNAP](https://github.com/simonnickel/snap-abstract) suite.


## Swift

Useful Swift extensions for convenience.


## SwiftUI

Extensions of SwiftUI types, convenience Views and workaround implementations for annoying default bahaviour or bugs.

### Highlights:

Conditional Modifier:
```
var shouldApplyBackground: Bool
Text("Hello, world!")
	.if(shouldApplyBackground) { view in
		view.background(Color.red)
	} else: {
		view.background(Color.clear)
	}
```


## Others

Some generic types that might be useful for other packages.
