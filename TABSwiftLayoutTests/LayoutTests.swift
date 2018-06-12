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
  
  override func setUp() {
    testPriority = LayoutPriority(Float(arc4random_uniform(1001)))
  }
  
  private func simpleViewHierarchy() -> (UIView, UIView) {
    let superview = UIView()
    let subview = UIView()
    superview.addSubview(subview)
    return (superview, subview)
  }
  
  func testPinEdges() {
    let (sv, v) = simpleViewHierarchy()
    let constraints = v.pin(edges: .all, toView: sv, relation: .equal, margins: EdgeMargins(top: 1, left: 2, bottom: 3, right: 4), priority: testPriority)
    XCTAssertEqual(constraints.count, 4)
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .top && $0.constant == 1 })
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .left && $0.constant == 2 })
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .bottom && $0.constant == -3 })
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .right && $0.constant == -4 })
    constraints.forEach {
      XCTAssertTrue($0.isActive)
      XCTAssertEqual($0.firstItem as? UIView, v)
      XCTAssertEqual($0.secondItem as? UIView, sv)
      XCTAssertEqual($0.relation, .equal)
      XCTAssertEqual($0.priority, testPriority)
    }
    XCTAssertEqual(sv.constraints, constraints)
    XCTAssertEqual(v.constraints.count, 0)
  }
  
  func testPinEdge() {
    let (sv, v) = simpleViewHierarchy()
    let constraint = v.pin(edge: .top, toEdge: .bottom, ofView: sv, relation: .greaterThanOrEqual, margin: 20, priority: testPriority)
    XCTAssertEqual(constraint.firstAttribute, .top)
    XCTAssertEqual(constraint.firstItem as? UIView, v)
    XCTAssertEqual(constraint.secondAttribute, .bottom)
    XCTAssertEqual(constraint.secondItem as? UIView, sv)
    XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
    //it is minus 20 because +20 would be 20 beyond (below) the sv bottom
    XCTAssertEqual(constraint.constant, -20)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(sv.constraints, [constraint])
    XCTAssertEqual(v.constraints.count, 0)
  }
  
  func testAlignAxis() {
    let (sv, v) = simpleViewHierarchy()
    let constraint = v.align(axis: .horizontal, relativeTo: sv, offset: 20, priority: testPriority)
    XCTAssertEqual(constraint.firstAttribute, .centerX)
    XCTAssertEqual(constraint.firstItem as? UIView, v)
    XCTAssertEqual(constraint.secondAttribute, .centerX)
    XCTAssertEqual(constraint.secondItem as? UIView, sv)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.constant, 20)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(sv.constraints, [constraint])
    XCTAssertEqual(v.constraints.count, 0)
  }
  
  func testSizeAxisOfViews() {
    let (sv, v1) = simpleViewHierarchy()
    let v2 = UIView()
    sv.addSubview(v2)
    
    let constraints = sv.size(axis: .horizontal, ofViews: [v1, v2], ratio: 0.5, priority: testPriority)
    
    XCTAssertEqual(constraints.count, 2)
    XCTAssertTrue(constraints.contains { $0.firstItem as? UIView == v1 })
    XCTAssertTrue(constraints.contains { $0.firstItem as? UIView == v2 })
    constraints.forEach {
      XCTAssertTrue($0.isActive)
      XCTAssertEqual($0.secondItem as? UIView, sv)
      XCTAssertEqual($0.firstAttribute, .width)
      XCTAssertEqual($0.secondAttribute, .width)
      XCTAssertEqual($0.relation, .equal)
      XCTAssertEqual($0.multiplier, 0.5)
      XCTAssertEqual($0.constant, 0)
      XCTAssertEqual($0.priority, testPriority)
    }
    XCTAssertEqual(sv.constraints, constraints)
    XCTAssertEqual(v1.constraints.count, 0)
    XCTAssertEqual(v2.constraints.count, 0)
  }
  
  func testSizeAxisToConstant() {
    let (sv, v) = simpleViewHierarchy()
    
    let constraint = v.size(axis: .vertical, relatedBy: .equal, size: 200, priority: testPriority)
    
    XCTAssertEqual(constraint.firstAttribute, .height)
    XCTAssertEqual(constraint.firstItem as? UIView, v)
    XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
    XCTAssertEqual(constraint.secondItem as? UIView, nil)
    XCTAssertEqual(constraint.constant, 200)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(v.constraints, [constraint])
    XCTAssertEqual(sv.constraints.count, 0)
  }
  
  func testSizeAxisRelativeToOtherAxis() {
    let (sv, v) = simpleViewHierarchy()
    
    let constraint = v.size(axis: .vertical, relativeTo: .horizontal, ofView: v, ratio: 0.5, priority: testPriority)
    
    XCTAssertEqual(constraint.firstAttribute, .height)
    XCTAssertEqual(constraint.firstItem as? UIView, v)
    XCTAssertEqual(constraint.secondAttribute, .width)
    XCTAssertEqual(constraint.secondItem as? UIView, v)
    XCTAssertEqual(constraint.constant, 0)
    XCTAssertEqual(constraint.multiplier, 0.5)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, testPriority)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(v.constraints, [constraint])
    XCTAssertEqual(sv.constraints.count, 0)
  }
  
  func testSizeBothAxisToConstant() {
    let (sv, v) = simpleViewHierarchy()
    
    let constraints = v.size(width: 200, height: 300, relation: .greaterThanOrEqual, priority: testPriority)
    
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .width && $0.constant == 200 })
    XCTAssertTrue(constraints.contains { $0.firstAttribute == .height && $0.constant == 300 })
    constraints.forEach {
      XCTAssertEqual($0.firstItem as? UIView, v)
      XCTAssertEqual($0.secondAttribute, .notAnAttribute)
      XCTAssertEqual($0.secondItem as? UIView, nil)
      XCTAssertEqual($0.multiplier, 1)
      XCTAssertEqual($0.relation, .greaterThanOrEqual)
      XCTAssertEqual($0.priority, testPriority)
      XCTAssertTrue($0.isActive)
    }
    XCTAssertEqual(v.constraints, constraints)
    XCTAssertEqual(sv.constraints.count, 0)
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
      let (sv, v) = simpleViewHierarchy()
      
      v.align(edges: edgeMask, toView: sv)
      
      let constraints = sv.constraints
      for edge in edges {
        XCTAssertTrue(constraints.contains { $0.firstAttribute == edge && $0.secondAttribute == edge})
      }
      constraints.forEach {
        XCTAssertEqual($0.firstItem as? UIView, v)
        XCTAssertEqual($0.secondItem as? UIView, sv)
        XCTAssertEqual($0.constant, 0)
        XCTAssertEqual($0.multiplier, 1)
        XCTAssertEqual($0.relation, .equal)
        XCTAssertEqual($0.priority, .required)
        XCTAssertTrue($0.isActive)
      }
      
      XCTAssertEqual(v.constraints.count, 0)
      _ = edges.popLast()
    }
  }
  
  
  func testAlignHorizontally() {
    let (sv, v) = simpleViewHierarchy()
    
    let constraint = v.alignHorizontally(toView: sv)
    
    XCTAssertEqual(constraint.firstAttribute, .centerX)
    XCTAssertEqual(constraint.firstItem as? UIView, v)
    XCTAssertEqual(constraint.secondAttribute, .centerX)
    XCTAssertEqual(constraint.secondItem as? UIView, sv)
    XCTAssertEqual(constraint.constant, 0)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, .required)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(sv.constraints, [constraint])
    XCTAssertEqual(v.constraints.count, 0)
  }
  
  func testAlignVertically() {
    let (sv, v) = simpleViewHierarchy()
    
    let constraint = v.alignVertically(toView: sv)
    
    XCTAssertEqual(constraint.firstAttribute, .centerY)
    XCTAssertEqual(constraint.firstItem as? UIView, v)
    XCTAssertEqual(constraint.secondAttribute, .centerY)
    XCTAssertEqual(constraint.secondItem as? UIView, sv)
    XCTAssertEqual(constraint.constant, 0)
    XCTAssertEqual(constraint.multiplier, 1)
    XCTAssertEqual(constraint.relation, .equal)
    XCTAssertEqual(constraint.priority, .required)
    XCTAssertTrue(constraint.isActive)
    
    XCTAssertEqual(sv.constraints, [constraint])
    XCTAssertEqual(v.constraints.count, 0)
  }
  
  func testResetConstraints() {
    let (sv, v) = simpleViewHierarchy()
    
    let constraint = v.size(axis: .vertical, relatedBy: .equal, size: 200, priority: testPriority)
    
    XCTAssertEqual(v.constraints, [constraint])
    XCTAssertEqual(sv.constraints.count, 0)
    
    v.resetConstraints()
    
    XCTAssertEqual(v.constraints.count, 0)
  }
  
  func testResetSubViewConstraints() {
    let (sv, v) = simpleViewHierarchy()
    
    let sizeConstraint = sv.size(axis: .vertical, relatedBy: .equal, size: 200, priority: testPriority)
    
    var allConstraints = v.pin(edges: .all, toView: sv)
    allConstraints.append(sizeConstraint)
    
    XCTAssertEqual(Set(sv.constraints), Set(allConstraints))
    XCTAssertEqual(v.constraints.count, 0)
    
    sv.resetSubViewConstraints()
    
    XCTAssertEqual(sv.constraints, [sizeConstraint])
    XCTAssertEqual(v.constraints.count, 0)
  }
  
}
