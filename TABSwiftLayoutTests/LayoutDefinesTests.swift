//
//  LayoutDefinesTests.swift
//  LayoutDefinesTests
//
//  Created by Jonathan on 29/12/2017.
//  Copyright © 2017 TheAppBusiness. All rights reserved.
//

import XCTest
@testable import TABSwiftLayout

class LayoutDefinesTests: XCTestCase {
  
  func testSameEdgeMasksAreSame() {
    XCTAssertEqual(EdgeMask.top, .top)
    XCTAssertEqual(EdgeMask.left, .left)
    XCTAssertEqual(EdgeMask.bottom, .bottom)
    XCTAssertEqual(EdgeMask.right, .right)
  }
  
  func testDifferentEdgeMasksAreDifferent() {
    XCTAssertNotEqual(EdgeMask.top, .left)
    XCTAssertNotEqual(EdgeMask.top, .bottom)
    XCTAssertNotEqual(EdgeMask.top, .right)
    
    XCTAssertNotEqual(EdgeMask.left, .top)
    XCTAssertNotEqual(EdgeMask.left, .bottom)
    XCTAssertNotEqual(EdgeMask.left, .right)
    
    XCTAssertNotEqual(EdgeMask.bottom, .top)
    XCTAssertNotEqual(EdgeMask.bottom, .left)
    XCTAssertNotEqual(EdgeMask.bottom, .right)
    
    XCTAssertNotEqual(EdgeMask.right, .top)
    XCTAssertNotEqual(EdgeMask.right, .left)
    XCTAssertNotEqual(EdgeMask.right, .bottom)
  }
  
  func testEdgeMasksCombinedEdges() {
    XCTAssertEqual(EdgeMask.leftAndRight, [.left, .right])
    XCTAssertEqual(EdgeMask.topAndBottom, [.top, .bottom])
    XCTAssertEqual(EdgeMask.all, EdgeMask.leftAndRight.union(.topAndBottom))
  }
  
  func testEdgeMarginsDefaultInit() {
    let margins = EdgeMargins()
    XCTAssertEqual(margins.top, 0)
    XCTAssertEqual(margins.left, 0)
    XCTAssertEqual(margins.bottom, 0)
    XCTAssertEqual(margins.right, 0)
  }
  
  func testEdgeMarginsAllInit() {
    let margins = EdgeMargins(all: 5)
    XCTAssertEqual(margins.top, 5)
    XCTAssertEqual(margins.bottom, 5)
    XCTAssertEqual(margins.left, 5)
    XCTAssertEqual(margins.right, 5)
  }
  
  func testEdgeMarginsStandardInit() {
    let margins = EdgeMargins(top: 1, left: 2, bottom: 3, right: 4)
    XCTAssertEqual(margins.top, 1)
    XCTAssertEqual(margins.left, 2)
    XCTAssertEqual(margins.bottom, 3)
    XCTAssertEqual(margins.right, 4)
  }
  
  func testEdgeMarginsHorizontalAndVerticalInit() {
    let margins = EdgeMargins(horizontal: 7, vertical: 8)
    XCTAssertEqual(margins.top, 8)
    XCTAssertEqual(margins.left, 7)
    XCTAssertEqual(margins.bottom, 8)
    XCTAssertEqual(margins.right, 7)
  }
  
  func testEdgeMarginsZero() {
    let margins = EdgeMargins.zero
    XCTAssertEqual(margins.top, 0)
    XCTAssertEqual(margins.left, 0)
    XCTAssertEqual(margins.bottom, 0)
    XCTAssertEqual(margins.right, 0)
  }
  
  func testSizeAttributeConversion() {
    XCTAssertEqual(Axis.horizontal.sizeAttribute, .width)
    XCTAssertEqual(Axis.vertical.sizeAttribute, .height)
  }
  
  func testCenterAttributeConversion() {
    XCTAssertEqual(Axis.horizontal.centerAttribute, .centerX)
    XCTAssertEqual(Axis.vertical.centerAttribute, .centerY)
  }
  
  func testEdgeAttributeConversion() {
    XCTAssertEqual(Edge.top.attribute, .top)
    XCTAssertEqual(Edge.left.attribute, .left)
    XCTAssertEqual(Edge.bottom.attribute, .bottom)
    XCTAssertEqual(Edge.right.attribute, .right)
  }
}
