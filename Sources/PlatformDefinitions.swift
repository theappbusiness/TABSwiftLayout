//
//  PlatformDefinitions.swift
//  TABSwiftLayout
//
//  Created by Jonathan Bailey on 22/12/2017.
//  Copyright © 2017 TheAppBusiness. All rights reserved.
//

#if os(OSX)
  import AppKit
  public typealias View = NSView
  public typealias LayoutPriority = NSLayoutConstraint.Priority
  public typealias LayoutAttribute = NSLayoutConstraint.Attribute
  public typealias LayoutRelation = NSLayoutConstraint.Relation
#else
  import UIKit
  public typealias View = UIView
  public typealias LayoutPriority = UILayoutPriority
  public typealias LayoutAttribute = NSLayoutConstraint.Attribute
  public typealias LayoutRelation = NSLayoutConstraint.Relation
#endif
