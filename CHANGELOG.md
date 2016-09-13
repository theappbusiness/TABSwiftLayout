# Change Log

## 1.3

## New Features
- Support for Swift 3

## API updates
- Renamed TABSwiftLayout functions:
	-  `pin(_:toView:relation:margins:priority:)` to `pin(edges:toView:relation:margins:priority:)`
	
	-  `pin(_:toEdge:ofView:relation:margin:priority:)` to `pin(edge:toEdge:ofView:relation:margin:priority:)`

	-  `align(_:relativeTo:offset:priority:)` to `align(axis:relativeTo:offset:priority:)`

	-  `size(_:ofViews:ratio:priority:)` to `size(axis:ofViews:ratio:priority:)`

	-  `size(_:relatedBy:size:priority:)` to `size(axis:relatedBy:size:priority:)`

	-  `size(_:relativeTo:ofView:ratio:priority:)` to `"size(axis:relativeTo:ofView:ratio:priority:)`

	-  `alignEdges(_:toView:)` to `alignEdges(edges:toView:)`

	-  `alignTop(_:)` to `alignTop(toView:)`

	-  `alignBottom(_:)` to `alignBottom(toView:)`

	-  `alignRight(_:)` to `alignRight(toView:)`

	-  `alignHorizontally(_:)` to `alignHorizontally(toView:)`

	-  `alignVertically(_:)` to `alignVertically(toView:)`