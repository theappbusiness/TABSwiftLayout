# Swift Layout

## What does it do?

A library for providing a flexible, yet very minimal API for dealing with AutoLayout programatically.

## Why would I use it?

Using the standard Apple API is very cumbersome. Even something simple like constraining the width of a view:

```swift
let constraint = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 100)
NSLayoutConstraint.activateConstraints([constraint])
```

Now with SwiftLayout:

```swift
view.size(.Horizontal, relatedBy: .Equal, size: 100)
```

As you can see, SwiftLayout also removes the need for you to activate your constraints, and removes the redundancy required in Apple's API.

## What can I do with it?

Currently all the most common layout tasks can be completed with SwiftLayout.

Position:

```swift
view.pin(.Top, toEdge: .Top, ofView: view.superview, margin: 15)
view.pin(.Left.union(.Right), ofView: view.superview, margins: EdgeMarginsMask(0, 15, 0, 15))
```

Sizing:

```swift
view.size(.Horizontal, ofViews: [view], ratio: 1)
view.size(.Horizontal, relatedBy: .Equal, size: 100)
view.size(.Horizontal, relativeTo: .Horizontal, ofView: view.superview, ratio: 0.5)
```

Alignment (convenience methods):

```
view.alignTop(toView: otherView)
view.alignBottom(toView: otherView)
view.alignLeft(toView: otherView)
view.alignRight(toView: otherView)

view.centerHorizontally(toView: otherView)
view.centerVertically(toView: otherView)
```

## Caveats

As with Apple's API, you MUST ensure your view has been added to a superview BEFORE setting any constraints on it. However with SwiftLayout, the contraints will NOT be added in this case, and a nice print() message will indicate that you've made a mistake.

## Additional API

SwiftLayout also includes an additional set of API for inspecting the types of constraints currently applied to a view. 

```swift
let constraints = view.viewConstraints
```

This API differs slightly from Apple's implementation, since it will return automatically scan through the superview as well, in order to return ALL constraints currently being applied to this view.

```swift
let constraints = view.constraintsForTrait(.LeftMargin)
```

This is extremely useful when you need to adjust the constant or replace a specific constraint entirely. Even better, its a bitmask, so you can request multiple constraints at once ;)

```swift
if (view.containsTraits(.LeftMargin)) {
  ...
}
```

Finally, you can also inspect a view, to determine if it contains a specific set of layout traits.