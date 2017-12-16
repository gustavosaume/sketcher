//
//  SketchViewInterface.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/19/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit

@objc enum ToolbarState: Int {
  case closed, edge, brightness, hidden
}


@objc protocol SketchViewInterface: class {
  var toolbarState: ToolbarState { get set }
  var currentFilters: FiltersBridge { get }

  func lockImage()
  func unlockImage()
  func toggleControls()
  func toggleToolbar(visible: Bool)

  func update(filters: FiltersBridge)
}

class FiltersBridge: NSObject {
  var lineOverlayFilter: LineOverlayFilter?

  init(lineOverlayFilter: LineOverlayFilter? = nil) {
    self.lineOverlayFilter = lineOverlayFilter
  }
}
