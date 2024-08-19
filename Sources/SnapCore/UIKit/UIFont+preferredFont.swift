//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

#if canImport(UIKit)
import UIKit

public extension UIFont {
	
	/// A wrapper around UIFont.preferredFont(forTextStyle:) with the options to specify Weight and SystemDesign.
	/// Uses UIFontMetrics to scale the font to DynamicType.
	/// Uses UIFontDescriptor to set the weight and design.
	/// - Parameters:
	///   - style: `UIFont.TextStyle` to get the preffered Font for.
	///   - weight: `UIFont.Weight`  to use for the result.
	///   - design: `UIFontDescriptor.SystemDesign` to use for the result.
	/// - Returns: A UIFont to fit the params.
	static func preferredFont(for style: UIFont.TextStyle, weight: UIFont.Weight, design: UIFontDescriptor.SystemDesign = .rounded) -> UIFont {
		let defaultFont = UIFont.preferredFont(forTextStyle: style)
		var fontDescriptor = defaultFont.fontDescriptor
		
		// Customizing weight
		fontDescriptor = fontDescriptor.addingAttributes([
			UIFontDescriptor.AttributeName.traits: [
				UIFontDescriptor.TraitKey.weight: weight.rawValue
			]
		])
		
		// Customizing design
		if let descriptor = fontDescriptor.withDesign(design) {
			fontDescriptor = descriptor
		}
		
		// Setup the font to be auto-scalable
		let metrics = UIFontMetrics(forTextStyle: style)
		return metrics.scaledFont(for: UIFont(descriptor: fontDescriptor, size: defaultFont.pointSize))
	}
	
}

#endif
