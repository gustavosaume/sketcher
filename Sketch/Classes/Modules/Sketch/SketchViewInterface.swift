//
//  SketchViewInterface.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/19/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol SketchViewInterface: class {
  func lockImage()
  func unlockImage()
  func toggleControls()
}
