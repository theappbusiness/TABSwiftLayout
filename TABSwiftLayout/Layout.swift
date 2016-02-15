/*
  Copyright © 2015 The App Business. All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

  THIS SOFTWARE IS PROVIDED BY THE APP BUSINESS `AS IS' AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
  EVENT SHALL THE APP BUSINESS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#if os(iOS)
  import UIKit
#else
  import AppKit
#endif


// MARK: - Extends UI/NS View to provide better support for programmatic constraints
extension View {
  
  
  /**
   Resests all constraints for this view (similar to Xcode)
   */
  public func resetConstraints() {
    removeConstraints(constraints)
  }
  
  /**
   Resets all constraints for this views subviews (similar to Xcode)
   */
  public func resetSubViewConstraints() {
    for constraint: NSLayoutConstraint in self.constraints {
      let item = constraint.firstItem as? View
      if item != self {
        removeConstraint(constraint)
      }
    }
  }
  
  /**
   Pins the edges of 2 associated views
   
   - parameter edges:  The edges (bitmask) to pin
   - parameter view:   The second view to pin to
   - parameter margins: The margins to apply for each applicable edge
   
   - returns: The constaints that were added to this view
   */
  public func pin(edges: EdgeMask, toView view: View, relation: NSLayoutRelation = .Equal, margins: EdgeMargins = EdgeMargins(), priority: LayoutPriority = LayoutPriorityRequired) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    if edges.contains(.Top) {
      constraints.append(pin(.Top, toEdge: .Top, ofView: view, relation: relation, margin: margins.top, priority: priority))
    }
    
    if edges.contains(.Bottom) {
      constraints.append(pin(.Bottom, toEdge: .Bottom, ofView: view, relation: relation, margin: margins.bottom, priority: priority))
    }
    
    if edges.contains(.Left) {
      constraints.append(pin(.Left, toEdge: .Left, ofView: view, relation: relation, margin: margins.left, priority: priority))
    }
    
    if edges.contains(.Right) {
      constraints.append(pin(.Right, toEdge: .Right, ofView: view, relation: relation, margin: margins.right, priority: priority))
    }
    
    return constraints
  }
  
  
  /**
   Pins a single edge to another views edge
   
   - parameter edge:   The edge of this view to pin
   - parameter toEdge: The edge of the second view to pin
   - parameter view:   The second view to pin to
   - parameter margin: The margin to apply to this constraint
   
   - returns: The constraint that was added
   */
  public func pin(edge: Edge, toEdge: Edge, ofView view: View, relation: NSLayoutRelation = .Equal, margin: CGFloat = 0, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = edgeAttribute(edge)
    constraint.secondAttribute = edgeAttribute(toEdge)
    constraint.constant = edge == .Right || toEdge == .Right || edge == .Bottom || toEdge == .Bottom ? -1 * margin : margin
    constraint.relation = relation
    constraint.priority = priority
    
    let layoutConstraint = constraint.constraint()
    NSLayoutConstraint.activateConstraints([layoutConstraint])
    return layoutConstraint
  }
  
  /**
   Aligns this views center to another view
   
   - parameter axis:   The axis to align
   - parameter view:   The second view to align to
   - parameter offset: The offset to apply to this alignment
   
   - returns: The constraint that was added
   */
  public func align(axis: Axis, relativeTo view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = centerAttribute(axis)
    constraint.secondAttribute = centerAttribute(axis)
    constraint.constant = offset
    constraint.priority = priority
    
    let layoutConstraint = constraint.constraint()
    NSLayoutConstraint.activateConstraints([layoutConstraint])
    return layoutConstraint
  }
  
  @available(*, deprecated=1.0, obsoleted=1.1, renamed="align") public func center(axis: Axis, relativeTo view: View, offset: CGFloat = 0, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    return align(axis, relativeTo: view, offset: offset, priority: priority)
  }
  
  /**
   Sizes the specified views proportionally to this view
   
   - parameter axis:  The axis to size
   - parameter views: The views to size
   - parameter ratio: The ratio to apply to this sizing (e.g. 0.5 would size the second view by 50% of this view's edge)
   
   - returns: The constraint that was added
   */
  public func size(axis: Axis, ofViews views: [View], ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityRequired) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    for view: View in views {
      constraints.append(view.size(axis, relativeTo: axis, ofView: self, ratio: ratio, priority: priority))
    }
    
    return constraints
  }
  
  /**
   Sizes this view
   
   - parameter axis:     The axis to size
   - parameter relation: The relation for this sizing, equal, greaterThanOrEqual, lessThanOrEqual
   - parameter size:     The size to set
   
   - returns: The constraint that was added
   */
  public func size(axis: Axis, relatedBy relation: NSLayoutRelation, size: CGFloat, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.firstAttribute = sizeAttribute(axis)
    constraint.secondAttribute = sizeAttribute(axis)
    constraint.relation = relation
    constraint.constant = size
    constraint.priority = priority
    
    let layoutConstraint = constraint.constraint()
    NSLayoutConstraint.activateConstraints([layoutConstraint])
    return layoutConstraint
  }
  
  /**
   Sizes this view's axis relative to another view axis. Note: The axis for each view doesn't have to be the same
   
   - parameter axis:      The axis to size
   - parameter otherAxis: The other axis to use for sizing
   - parameter view:      The second view to reference
   - parameter ratio:     The ratio to apply to this sizing. (e.g. 0.5 would size this view by 50% of the second view's edge)
   
   - returns: The constraint that was added
   */
  public func size(axis: Axis, relativeTo otherAxis: Axis, ofView view: View, ratio: CGFloat = 1, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint {
    var constraint = Constraint(view: self)
    
    constraint.secondView = view
    constraint.firstAttribute = sizeAttribute(axis)
    constraint.secondAttribute = sizeAttribute(otherAxis)
    constraint.multiplier = ratio
    constraint.priority = priority
    
    let layoutConstraint = constraint.constraint()
    NSLayoutConstraint.activateConstraints([layoutConstraint])
    return layoutConstraint
  }
  
}


// MARK: - Extends UI/NS View with some additional convenience methods
extension View {
  
  /**
   Sizes the view to the specified width and height
   
   - parameter width:  The width
   - parameter height: The height
   
   - returns: The constraint that was added
   */
  public func size(width width: CGFloat, height: CGFloat, relation: NSLayoutRelation = .Equal, priority: LayoutPriority = LayoutPriorityRequired) -> [NSLayoutConstraint] {
    let horizontal = size(.Horizontal, relatedBy: relation, size: width, priority: priority)
    let vertical = size(.Vertical, relatedBy: relation, size: height, priority: priority)
    return [horizontal, vertical]
  }
  
  public func alignEdges(edges: EdgeMask, toView: View) {
    if edges.contains(.Left) {
      alignLeft(toView)
    }
    
    if edges.contains(.Right) {
      alignRight(toView)
    }
    
    if edges.contains(.Top) {
      alignTop(toView)
    }
    
    if edges.contains(.Bottom) {
      alignBottom(toView)
    }
  }
  
  /**
   Aligns the top edge of this view to the top of the specified view
   
   - parameter view: The reference view to align to
   
   - returns: The constraint that was added
   */
  public func alignTop(toView: View) -> NSLayoutConstraint {
    return pin(.Top, toEdge: .Top, ofView: toView, margin: frame.minY)
  }
  
  /**
   Aligns the top edge of this view to the top of the specified view
   
   - parameter view: The reference view to align to
   
   - returns: The constraint that was added
   */
  public func alignLeft(toView: View) -> NSLayoutConstraint {
    return pin(.Left, toEdge: .Left, ofView: toView, margin: frame.minX)
  }
  
  /**
   Aligns the top edge of this view to the top of the specified view
   
   - parameter view: The reference view to align to
   
   - returns: The constraint that was added
   */
  public func alignBottom(toView: View) -> NSLayoutConstraint {
    return pin(.Bottom, toEdge: .Bottom, ofView: toView, margin: toView.bounds.maxY - frame.maxY)
  }
  
  /**
   Aligns the top edge of this view to the top of the specified view
   
   - parameter view: The reference view to align to
   
   - returns: The constraint that was added
   */
  public func alignRight(toView: View) -> NSLayoutConstraint {
    return pin(.Right, toEdge: .Right, ofView: toView, margin: toView.bounds.maxX - frame.maxX)
  }
  
  /**
   Aligns the center vertically to the specified view
   
   - parameter view: The reference view to align to
   
   - returns: The constraint that was added
   */
  public func alignHorizontally(toView: View) -> NSLayoutConstraint {
    return align(.Horizontal, relativeTo: toView, offset: 0)
  }
  
  @available(*, deprecated=1.0, obsoleted=1.1, renamed="alignHorizontally") public func centerHorizontally(toView: View) -> NSLayoutConstraint {
    return alignHorizontally(toView)
  }
  
  /**
   Aligns the center vertically to the specified view
   
   - parameter view: The reference view to align to
   
   - returns: The constraint that was added
   */
  public func alignVertically(toView: View) -> NSLayoutConstraint {
    return align(.Vertical, relativeTo: toView, offset: 0)
  }
  
  @available(*, deprecated=1.0, obsoleted=1.1, renamed="alignVertically") public func centerVertically(toView: View) -> NSLayoutConstraint {
    return alignVertically(toView)
  }
  
}

