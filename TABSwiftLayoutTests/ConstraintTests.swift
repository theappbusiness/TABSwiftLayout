//
//  ConstraintTests.swift
//  TABSwiftLayoutTests
//
//  Created by Jonathan on 29/12/2017.
//  Copyright © 2017 TheAppBusiness. All rights reserved.
//

import XCTest

class ConstraintTests: XCTestCase {
  
  private func simpleConstraint(view: UIView = UIView(), attribute: NSLayoutAttribute) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: UIView(), attribute: attribute, multiplier: 1, constant: 0)
  }
  
  func testConstraintTrait() {
    XCTAssertEqual(simpleConstraint(attribute: .top).trait, .TopMargin)
    XCTAssertEqual(simpleConstraint(attribute: .left).trait, .LeftMargin)
    XCTAssertEqual(simpleConstraint(attribute: .leading).trait, .LeftMargin)
    XCTAssertEqual(simpleConstraint(attribute: .right).trait, .RightMargin)
    XCTAssertEqual(simpleConstraint(attribute: .trailing).trait, .RightMargin)
    XCTAssertEqual(simpleConstraint(attribute: .bottom).trait, .BottomMargin)
    
    XCTAssertEqual(simpleConstraint(attribute: .centerX).trait, .HorizontalAlignment)
    XCTAssertEqual(simpleConstraint(attribute: .centerY).trait, .VerticalAlignment)
    
    XCTAssertEqual(simpleConstraint(attribute: .width).trait, .HorizontalSizing)
    XCTAssertEqual(simpleConstraint(attribute: .height).trait, .VerticalSizing)
    
    XCTAssertEqual(simpleConstraint(attribute: .lastBaseline).trait, .None)
  }
}
