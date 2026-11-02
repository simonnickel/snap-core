# TODO

Outstanding work on the package.

## TODO-1: Limit adjusted color values

`Color.adjusted` passes values outside of `0...1` on to `Color`, such as `1.15` after adding `0.25` to a hue of `0.9`.

- Check what `Color` does with such values.
- Wrap the hue around and limit the other values to the range, unless the check shows a reason not to.
- Add tests for values that leave the range.

## TODO-2: SemanticVersion parsing

`SemanticVersion` links to https://semver.org, but parses differently.

- It rejects `1.2.3-rc`, which is valid.
- It accepts `1.2.3.rc`, `1.2.3.4`, `1.2.3.` and `+1.2.3`, which are invalid.
- It accepts `12`, `12.13` and `12..14`, which are also invalid. The tests still expect these.

Decide what the type represents:

- Follow the spec, including pre-release versions and their ordering.
- Or represent plain app versions, stated in its doc comment, with the accepted formats defined there.

Then change the parsing and add tests for the decided behavior.
