<!-- Copy badges from SPI -->
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-core%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/simonnickel/snap-core)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-core%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/simonnickel/snap-core) 

> This package is part of the [SNAP](https://github.com/simonnickel/snap-abstract) suite.


# SnapCore

A collection of useful helper implementations, common extensions, convenience definitions and workarounds.

[![Documentation][documentation badge]][documentation] 

[documentation]: https://swiftpackageindex.com/simonnickel/snap-core/main/documentation/snapcore
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue


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


## UIKit

When using SwiftUI, sometimes you just have to peek behind the curtain to get things right. The package contains some Extensions that are used by other packages of the Snap suite. 


## Others

Some generic types that might be useful for other packages.
