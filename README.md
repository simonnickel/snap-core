[documentation]: https://swiftpackageindex.com/simonnickel/SnapCore/main/documentation
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue


# SnapCore
[![Documentation][documentation badge]][documentation]
> This package is part of the [SNAP](https://github.com/simonnickel/snap-abstract) suite.

A collection of useful helper implementations and common extensions for Swift and SwiftUI.


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
