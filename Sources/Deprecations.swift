//
//  Deprecations.swift
//  TABSwiftLayout
//
//  Created by Daniela Bulgaru on 13/09/2016.
//  Copyright © 2016 TheAppBusiness. All rights reserved.
//

import Foundation

#if os(iOS)
  import UIKit
#else
  import AppKit
#endif

extension View {
  
  @available(*, deprecated:2.0.0, renamed: "pin(edges:toView:relation:margins:priority:)")
  public func pin(_ edges: EdgeMask, toView view: View, relation: LayoutRelation = .equal, margins: EdgeMargins = EdgeMargins(), priority: LayoutPriority = LayoutPriorityRequired) -> [NSLayoutConstraint] {
    return pin(edges: edges, toView: view, relation: relation, margins: margins, priority: priority)
  }
  

  @available(*, deprecated:2.0.0, renamed: "pin(edge:toEdge:ofView:relation:margin:priority:)")
  public func pin(_ edge: Edge, toEdge: Edge, ofView view: View, relation: LayoutRelation = .equal, margin: CGFloat = 0, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    return pin(edge: edge, toEdge: toEdge, ofView: view, relation: relation, margin: margin, priority: priority)
  }

  @available(*, deprecated:2.0.0, renamed: "align(axis:relativeTo:offset:priority:)")
  public func align(_ axis: Axis, relativeTo view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    return align(axis: axis, relativeTo: view, offset: offset, priority: priority)
  }
  
  @available(*, deprecated:2.0.0, renamed: "size(axis:ofViews:ratio:priority:)")
  public func size(_ axis: Axis, ofViews views: [View], ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityRequired) -> [NSLayoutConstraint] {
    return size(axis: axis, ofViews: views, ratio: ratio, priority: priority)
  }
  
  @available(*, deprecated:2.0.0, renamed: "size(axis:relatedBy:size:priority:)")
  public func size(_ axis: Axis, relatedBy relation: LayoutRelation, size: CGFloat, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    return self.size(axis: axis, relatedBy: relation, size: size, priority: priority)
  }
  
  @available(*, deprecated:2.0.0, renamed: "size(axis:relativeTo:ofView:ratio:priority:)")
  public func size(_ axis: Axis, relativeTo otherAxis: Axis, ofView view: View, ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    return size(axis: axis, relativeTo: otherAxis, ofView: view, ratio: ratio, priority: priority)
  }
}


extension View {

  @available(*, deprecated:2.0.0, renamed: "alignEdges(edges:toView:)")
  public func alignEdges(_ edges: EdgeMask, toView: View) {
    align(edges: edges, toView: toView)
  }
  
  @available(*, deprecated:2.0.0, renamed: "alignTop(toView:)")
  public func alignTop(_ toView: View) -> NSLayoutConstraint {
    return alignTop(toView: toView)
  }
  
  @available(*, deprecated:2.0.0, renamed: "alignLeft(toView:)")
  public func alignLeft(_ toView: View) -> NSLayoutConstraint {
    return alignLeft(toView: toView)
  }
  
  @available(*, deprecated:2.0.0, renamed: "alignBottom(toView:)")
  public func alignBottom(_ toView: View) -> NSLayoutConstraint {
    return alignBottom(toView: toView)
  }
  
  @available(*, deprecated:2.0.0, renamed: "alignRight(toView:)")
  public func alignRight(_ toView: View) -> NSLayoutConstraint {
    return alignRight(toView: toView)
  }
  
  @available(*, deprecated:2.0.0, renamed: "alignHorizontally(toView:)")
  public func alignHorizontally(_ toView: View) -> NSLayoutConstraint {
    return alignHorizontally(toView: toView)
  }

  @available(*, deprecated:2.0.0, renamed: "alignVertically(toView:)")
  public func alignVertically(_ toView: View) -> NSLayoutConstraint {
    return alignVertically(toView: toView)
  }
}

extension View {
  
  @available(*, deprecated: 1.0, obsoleted: 1.1, renamed: "align") public func center(_ axis: Axis, relativeTo view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    return align(axis, relativeTo: view, offset: offset, priority: priority)
  }
  
  @available(*, deprecated: 1.0, obsoleted: 1.1, renamed: "alignVertically") public func centerVertically(toView: View) -> NSLayoutConstraint {
    return alignVertically(toView: toView)
  }
  
  @available(*, deprecated: 1.0, obsoleted: 1.1, renamed: "alignHorizontally") public func centerHorizontally(toView: View) -> NSLayoutConstraint {
    return alignHorizontally(toView: toView)
  }
  
}

public extension View {

  @available(*, deprecated:2.0.0, renamed: "constraints(forTrait:)")
  public func constraintsForTrait(_ trait: ConstraintsTraitMask) -> [NSLayoutConstraint] {
    return constraints(forTrait: trait)
  }
  
  @available(*, deprecated:2.0.0, renamed: "contains(trait:)")
  public func containsTraits(_ trait: ConstraintsTraitMask) -> Bool {
    return contains(trait: trait)
  }
}

