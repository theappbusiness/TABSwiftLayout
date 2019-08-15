//
//  LayoutTests.swift
//  TABSwiftLayoutTests
//
//  Created by Jonathan on 29/12/2017.
//  Copyright © 2017 TheAppBusiness. All rights reserved.
//

import XCTest
@testable import TABSwiftLayout

class LayoutTests: XCTestCase {
  
  private var testPriority: LayoutPriority!
  private var superview: UIView!
  private var view: UIView!
  
  
  override func setUp() {
    testPriority = LayoutPriority(Float(arc4random_uniform(1001)))
    superview = UIView()
    view = UIView()
    superview.addSubview(view)
  }
  
  func testPinEdges() {
    superview.bounds.size = CGSize(width: 300, height: 300)
    let constraints = view.pin(edges: .all, toView: superview, relation: .equal, margins: EdgeMargins(top: 1, left: 2, bottom: 3, right: 4), priority: testPriority)
    XCTAssertEqual(constraints.count, 4)
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .top && $0.constant == 1 })
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .left && $0.constant == 2 })
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .bottom && $0.constant == -3 })
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .right && $0.constant == -4 })
    constraints.forEach {
      XCTAssertTrue($0.isActive)
      XCTAssertEqual($0.firstItem as? UIView, view)
      XCTAssertEqual($0.secondItem as? UIView, superview)
      XCTAssertEqual($0.relation, .equal)
      XCTAssertEqual($0.priority, testPriority)
    }
    XCTAssertEqual(superview.constraints, constraints)
    XCTAssertEqual(view.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(superview.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(view.frame, CGRect(x: 2, y: 1, width: 294, height: 296))
  }
  
  func testPinEdge() {
    superview.bounds.size = CGSize(width: 300, height: 300)
    let constraint = view.pin(edge: .top, toEdge: .bottom, ofView: superview, relation: .greaterThanOrEqual, margin: 20, priority: testPriority)
    XCTAssertEqual(constraint.firstAttribute, .top)
    XCTAssertEqual(constraint.firstItem as? UIView, view)
    XCTAssertEqual(constraint.secondAttribute, .bottom)
    XCTAssertEqual(constraint.secondItem as? UIView, superview)
    XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
    //it is minus 20 because +20 would be 20 beyond (below) the sv bottom
    XCTAssertEqual(constraint.constant, -20)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(superview.constraints, [constraint])
    XCTAssertEqual(view.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(superview.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(view.frame, CGRect(x: 0, y: 280, width: 0, height: 0))
  }
  
  func testPinSameEdge() {
    superview.bounds.size = CGSize(width: 300, height: 300)
    let constraint = view.pin(edge: .right, toView: superview, relation: .lessThanOrEqual, margin: 30, priority: testPriority)
    XCTAssertEqual(constraint.firstAttribute, .right)
    XCTAssertEqual(constraint.firstItem as? UIView, view)
    XCTAssertEqual(constraint.secondAttribute, .right)
    XCTAssertEqual(constraint.secondItem as? UIView, superview)
    XCTAssertEqual(constraint.relation, .lessThanOrEqual)
    XCTAssertEqual(constraint.constant, -30)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(superview.constraints, [constraint])
    XCTAssertEqual(view.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(superview.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(view.frame, CGRect(x: 270, y: 0, width: 0, height: 0))
  }
  
  func testAlignAxis() {
    superview.bounds.size = CGSize(width: 300, height: 300)
    let constraint = view.align(axis: .horizontal, relativeTo: superview, offset: 20, priority: testPriority)
    XCTAssertEqual(constraint.firstAttribute, .centerX)
    XCTAssertEqual(constraint.firstItem as? UIView, view)
    XCTAssertEqual(constraint.secondAttribute, .centerX)
    XCTAssertEqual(constraint.secondItem as? UIView, superview)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.constant, 20)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(superview.constraints, [constraint])
    XCTAssertEqual(view.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(superview.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(view.frame, CGRect(x: 170, y: 0, width: 0, height: 0))
  }
  
  func testSizeAxisOfViews() {
    superview.bounds.size = CGSize(width: 300, height: 300)
    let v1: UIView! = view
    let v2 = UIView()
    superview.addSubview(v2)
    
    let constraints = superview.size(axis: .horizontal, ofViews: [v1, v2], ratio: 0.5, priority: testPriority)
    
    XCTAssertEqual(constraints.count, 2)
    XCTAssertTrue(constraints.contains { $0.firstItem as? UIView == v1 })
    XCTAssertTrue(constraints.contains { $0.firstItem as? UIView == v2 })
    constraints.forEach {
      XCTAssertTrue($0.isActive)
      XCTAssertEqual($0.secondItem as? UIView, superview)
      XCTAssertEqual($0.firstAttribute, .width)
      XCTAssertEqual($0.secondAttribute, .width)
      XCTAssertEqual($0.relation, .equal)
      XCTAssertEqual($0.multiplier, 0.5)
      XCTAssertEqual($0.constant, 0)
      XCTAssertEqual($0.priority, testPriority)
    }
    XCTAssertEqual(superview.constraints, constraints)
    XCTAssertEqual(v1.constraints.count, 0)
    XCTAssertEqual(v2.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(superview.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(v1.frame, CGRect(x: 0, y: 0, width: 150, height: 0))
    XCTAssertEqual(v2.frame, CGRect(x: 0, y: 0, width: 150, height: 0))
  }
  
  func testSizeAxisToConstant() {
    let horizontalConstraint = view.size(axis: .horizontal, size: 300)
    let constraint = view.size(axis: .vertical, relatedBy: .equal, size: 200, priority: testPriority)
    
    XCTAssertEqual(constraint.firstAttribute, .height)
    XCTAssertEqual(constraint.firstItem as? UIView, view)
    XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
    XCTAssertEqual(constraint.secondItem as? UIView, nil)
    XCTAssertEqual(constraint.constant, 200)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(Set(view.constraints), [constraint, horizontalConstraint])
    XCTAssertEqual(superview.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 300, height: 200))
  }
  
  func testSizeAxisRelativeToOtherAxis() {
    let horizontalConstraint = view.size(axis: .horizontal, size: 300)
    let constraint = view.size(axis: .vertical, relativeTo: .horizontal, ofView: view, ratio: 0.5, priority: testPriority)
    
    XCTAssertEqual(constraint.firstAttribute, .height)
    XCTAssertEqual(constraint.firstItem as? UIView, view)
    XCTAssertEqual(constraint.secondAttribute, .width)
    XCTAssertEqual(constraint.secondItem as? UIView, view)
    XCTAssertEqual(constraint.constant, 0)
    XCTAssertEqual(constraint.multiplier, 0.5)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(Set(view.constraints), [constraint, horizontalConstraint])
    XCTAssertEqual(superview.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 300, height: 150))
  }
  
  func testSizeSameAxis() {
    superview.bounds.size = CGSize(width: 300, height: 300)
    let constraint = view.size(axis: .vertical, toView: superview, ratio: 0.5, priority: testPriority)
    
    XCTAssertEqual(constraint.firstAttribute, .height)
    XCTAssertEqual(constraint.firstItem as? UIView, view)
    XCTAssertEqual(constraint.secondAttribute, .height)
    XCTAssertEqual(constraint.secondItem as? UIView, superview)
    XCTAssertEqual(constraint.constant, 0)
    XCTAssertEqual(constraint.multiplier, 0.5)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(superview.constraints, [constraint])
    XCTAssertEqual(view.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(superview.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 0, height: 150))
  }
  
  func testSizeBothAxisToConstant() {
    let constraints = view.size(width: 200, height: 300, relation: .greaterThanOrEqual, priority: testPriority)
    
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .width && $0.constant == 200 })
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .height && $0.constant == 300 })
    constraints.forEach {
      XCTAssertEqual($0.firstItem as? UIView, view)
      XCTAssertEqual($0.secondAttribute, .notAnAttribute)
      XCTAssertEqual($0.secondItem as? UIView, nil)
      XCTAssertEqual($0.multiplier, 1)
      XCTAssertEqual($0.relation, .greaterThanOrEqual)
      XCTAssertEqual($0.priority, testPriority)
      XCTAssertTrue($0.isActive)
    }
    XCTAssertEqual(view.constraints, constraints)
    XCTAssertEqual(superview.constraints.count, 0)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 200, height: 300))
  }
  
  func testAlignEdgesToView() {
    var edges: [NSLayoutAttribute] = [.top, .bottom, .left, .right]
    
    while edges.count > 0 {
      let edgeMask: EdgeMask = edges.reduce(into: EdgeMask(rawValue: 0)) { (result, next) in
        switch next {
        case .left:
          result.insert(.left)
        case .right:
          result.insert(.right)
        case .top:
          result.insert(.top)
        case .bottom:
          result.insert(.bottom)
        default:
          XCTFail()
        }
      }
      view.align(edges: edgeMask, toView: superview)
      
      XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
      let constraints = superview.constraints
      for edge in edges {
        XCTAssertTrue(constraints.contains { $0.firstAttribute == edge && $0.secondAttribute == edge})
      }
      constraints.forEach {
        XCTAssertEqual($0.firstItem as? UIView, view)
        XCTAssertEqual($0.secondItem as? UIView, superview)
        XCTAssertEqual($0.constant, 0)
        XCTAssertEqual($0.multiplier, 1)
        XCTAssertEqual($0.relation, .equal)
        XCTAssertEqual($0.priority, .required)
        XCTAssertTrue($0.isActive)
      }
      
      XCTAssertEqual(view.constraints.count, 0)
      _ = edges.popLast()
    }
  }
  
  
  func testAlignHorizontally() {
    superview.bounds.size = CGSize(width: 300, height: 300)
    let viewSize = view.size(width: 50, height: 50)
    let constraint = view.alignHorizontally(toView: superview)
    
    XCTAssertEqual(constraint.firstAttribute, .centerX)
    XCTAssertEqual(constraint.firstItem as? UIView, view)
    XCTAssertEqual(constraint.secondAttribute, .centerX)
    XCTAssertEqual(constraint.secondItem as? UIView, superview)
    XCTAssertEqual(constraint.constant, 0)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, .required)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(superview.constraints, [constraint])
    XCTAssertEqual(view.constraints, viewSize)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(superview.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(view.frame, CGRect(x: 125, y: 0, width: 50, height: 50))
  }
  
  func testAlignVertically() {
    superview.bounds.size = CGSize(width: 300, height: 300)
    let viewSize = view.size(width: 60, height: 60)
    let constraint = view.alignVertically(toView: superview)
    
    XCTAssertEqual(constraint.firstAttribute, .centerY)
    XCTAssertEqual(constraint.firstItem as? UIView, view)
    XCTAssertEqual(constraint.secondAttribute, .centerY)
    XCTAssertEqual(constraint.secondItem as? UIView, superview)
    XCTAssertEqual(constraint.constant, 0)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, .required)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(superview.constraints, [constraint])
    XCTAssertEqual(view.constraints, viewSize)
    
    superview.layoutIfNeeded()
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(superview.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(view.frame, CGRect(x: 0, y: 120, width: 60, height: 60))
  }
  
  func testResetConstraints() {
    let constraint = view.size(axis: .vertical, relatedBy: .equal, size: 200, priority: testPriority)
    
    XCTAssertEqual(view.constraints, [constraint])
    XCTAssertEqual(superview.constraints.count, 0)
    
    view.resetConstraints()
    
    XCTAssertEqual(view.constraints.count, 0)
  }
  
  func testResetSubViewConstraints() {
    let sizeConstraint = superview.size(axis: .vertical, relatedBy: .equal, size: 200, priority: testPriority)
    
    var allConstraints = view.pin(edges: .all, toView: superview)
    allConstraints.append(sizeConstraint)
    
    XCTAssertEqual(Set(superview.constraints), Set(allConstraints))
    XCTAssertEqual(view.constraints.count, 0)
    
    superview.resetSubViewConstraints()
    
    XCTAssertEqual(superview.constraints, [sizeConstraint])
    XCTAssertEqual(view.constraints.count, 0)
  }
  
}
