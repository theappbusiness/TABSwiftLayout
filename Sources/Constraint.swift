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

/// A required constraint.  Do not exceed this.
public let LayoutPriorityRequired: LayoutPriority = LayoutPriority(1000)
/// This is the priority level with which a button resists compressing its content.
public let LayoutPriorityDefaultHigh: LayoutPriority = LayoutPriority(750)
/// This is the priority level at which a button hugs its contents horizontally.
public let LayoutPriorityDefaultLow: LayoutPriority = LayoutPriority(250)

/**
*  The classes included in this file extend NSLayoutConstraints, provide Swift implementations and cross-platform support for iOS, OSX, Watch and Apple TV
*/

/**
Defines an abstract representation of a constraint
*/
public protocol ConstraintDefinition {
  var priority: LayoutPriority { get }
  var constant: CGFloat { get set }
  var multiplier: CGFloat { get }
  var relation: LayoutRelation { get }
  var firstAttribute: LayoutAttribute { get }
  var secondAttribute: LayoutAttribute { get }
  @available(*, deprecated:3.0.0)
  var trait: ConstraintsTraitMask { get }
}

/**
We extend the existing NSLayoutConstraint, as well as our own implementation ConstraintDefinition
*/
extension NSLayoutConstraint: ConstraintDefinition { }

/**
*  A Swift value-type implementation of NSLayoutConstraint
*/
public struct Constraint: ConstraintDefinition {
  
  public internal(set) var priority: LayoutPriority
  public var constant: CGFloat
  public internal(set) var multiplier: CGFloat
  public internal(set) var relation: LayoutRelation
  public internal(set) var firstAttribute: LayoutAttribute
  public internal(set) var secondAttribute: LayoutAttribute
  
  private var _enabled = true
  public var enabled: Bool {
    get {
      return self._enabled
    }
    set {
      self._enabled = enabled
      
      if (self.enabled) {
        NSLayoutConstraint.activate([self.constraint()])
      } else {
        NSLayoutConstraint.deactivate([self.constraint()])
      }
    }
  }
  
  public unowned var firstView: View {
    didSet {
      precondition(firstView.superview != nil, "The first view MUST be inserted into a superview before constraints can be applied")
    }
  }
  
  public weak var secondView: View?
  
  private weak var _constraint: NSLayoutConstraint?
  
  public init(view: View) {
    self.firstView = view
    self.firstAttribute = .notAnAttribute
    self.secondAttribute = .notAnAttribute
    self.constant = 0
    self.multiplier = 1
    self.relation = .equal
    self.priority = LayoutPriority(250)
    
    view.translatesAutoresizingMaskIntoConstraints = false
  }
  
  public mutating func constraint() -> NSLayoutConstraint {
    if self._constraint == nil {
      self._constraint = NSLayoutConstraint(
        item: self.firstView,
        attribute: firstAttribute,
        relatedBy: self.relation,
        toItem: self.secondView,
        attribute: self.secondAttribute,
        multiplier: self.multiplier,
        constant: self.constant)
      self._constraint?.priority = self.priority
    }
    
    return self._constraint!
  }
  
}
