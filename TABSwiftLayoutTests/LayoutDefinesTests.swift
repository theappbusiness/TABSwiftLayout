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
  
  
  func testSizeAttributeConversion() {
    XCTAssertEqual(sizeAttribute(axis: .horizontal), .width)
    XCTAssertEqual(sizeAttribute(axis: .vertical), .height)
  }
  
  func testCenterAttributeConversion() {
    XCTAssertEqual(centerAttribute(axis: .horizontal), .centerX)
    XCTAssertEqual(centerAttribute(axis: .vertical), .centerY)
  }
  
  func testEdgeAttributeConversion() {
    XCTAssertEqual(edgeAttribute(edge: .top), .top)
    XCTAssertEqual(edgeAttribute(edge: .left), .left)
    XCTAssertEqual(edgeAttribute(edge: .bottom), .bottom)
    XCTAssertEqual(edgeAttribute(edge: .right), .right)
  }
}
