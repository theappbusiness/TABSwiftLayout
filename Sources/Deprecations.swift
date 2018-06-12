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


/**
 *  Defines various constraint traits (bitmask) that define the type of constraints applied to a view.
 */
@available(*, deprecated:3.0.0)
public struct ConstraintsTraitMask: OptionSet {
  public let rawValue: Int
  public init(rawValue: Int) { self.rawValue = rawValue }
  
  
  /// No constraints applied
  public static var None: ConstraintsTraitMask   { return ConstraintsTraitMask(rawValue: 0) }
  
  
  /// A top margin constraint is applied
  public static var TopMargin: ConstraintsTraitMask   { return ConstraintsTraitMask(rawValue: 1 << 0) }
  
  /// A left margin constraint is applied
  public static var LeftMargin: ConstraintsTraitMask  { return ConstraintsTraitMask(rawValue: 1 << 1) }
  
  /// A right margin constraint is applied
  public static var RightMargin: ConstraintsTraitMask  { return ConstraintsTraitMask(rawValue: 1 << 2) }
  
  /// A bottom margin constraint is applied
  public static var BottomMargin: ConstraintsTraitMask   { return ConstraintsTraitMask(rawValue: 1 << 3) }
  
  /// A horitzontal alignment constraint is applied
  public static var HorizontalAlignment: ConstraintsTraitMask  { return ConstraintsTraitMask(rawValue: 1 << 4) }
  
  /// A vertical aligntment constraint is applied
  public static var VerticalAlignment: ConstraintsTraitMask  { return ConstraintsTraitMask(rawValue: 1 << 5) }
  
  /// A horizontal sizing constraint is applied
  public static var HorizontalSizing: ConstraintsTraitMask { return ConstraintsTraitMask(rawValue: 1 << 6) }
  
  /// A vertical sizing constraint is applied
  public static var VerticalSizing: ConstraintsTraitMask { return ConstraintsTraitMask(rawValue: 1 << 7) }
  
  /// Horizontal margin constraints are applied (Left and Right)
  public static var HorizontalMargins: ConstraintsTraitMask  { return LeftMargin.union(RightMargin) }
  
  /// Vertical margin constraints are applied (Top and Right)
  public static var VerticalMargins: ConstraintsTraitMask { return TopMargin.union(BottomMargin) }
}

// MARK: - This extends UI/NS View to provide additional constraints support
public extension View {
  
  /// Returns all constraints relevant to this view
  @available(*, deprecated:3.0.0)
  public var viewConstraints: [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    for constraint in self.constraints {
      constraints.append(constraint)
    }
    
    if let superviewConstraints = self.superview?.constraints {
      for constraint in superviewConstraints {
        if constraint.firstItem as? View != self && constraint.secondItem as? View != self {
          continue
        }
        
        constraints.append(constraint)
      }
    }
    
    return constraints
  }
  
  /**
   Returns all constraints for this view that match the specified traits
   
   - parameter trait: The traits to lookup
   
   - returns: An array of constraints. If no constraints exist, an empty array is returned. This method never returns nil
   */
  @available(*, deprecated:3.0.0)
  public func constraints(forTrait trait: ConstraintsTraitMask) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    for constraint in self.constraints {
      if constraint.trait == trait {
        constraints.append(constraint)
      }
    }
    
    if let superviewConstraints = self.superview?.constraints {
      for constraint in superviewConstraints {
        if constraint.firstItem as? View != self && constraint.secondItem as? View != self {
          continue
        }
        
        if trait.contains(constraint.trait) {
          constraints.append(constraint)
        }
      }
    }
    
    return constraints
  }
  
  /**
   Returns true if at least one constraint with the specified trait exists
   
   - parameter trait: The trait to test
   
   - returns: True if a constrait exists, false otherwise
   */
  @available(*, deprecated:3.0.0)
  public func contains(trait: ConstraintsTraitMask) -> Bool {
    var traits = ConstraintsTraitMask.None
    
    for constraint in constraints(forTrait: trait) {
      traits.insert(constraint.trait)
    }
    
    return traits.contains(trait)
  }
  
}

public extension ConstraintDefinition {
  @available(*, deprecated:3.0.0)
  public var trait: ConstraintsTraitMask {
    let left = self.firstAttribute == .left || self.firstAttribute == .leading
    let right = self.firstAttribute == .right || self.firstAttribute == .trailing
    let top = self.firstAttribute == .top
    let bottom = self.firstAttribute == .bottom
    
    let width = self.firstAttribute == .width
    let height = self.firstAttribute == .height
    
    let centerX = self.firstAttribute == .centerX
    let centerY = self.firstAttribute == .centerY
    
    if width { return .HorizontalSizing }
    if height { return .VerticalSizing }
    
    if centerX { return .HorizontalAlignment }
    if centerY { return .VerticalAlignment }
    
    if left { return .LeftMargin }
    if right { return .RightMargin }
    if top { return .TopMargin }
    if bottom { return .BottomMargin }
    
    return .None
  }
}


