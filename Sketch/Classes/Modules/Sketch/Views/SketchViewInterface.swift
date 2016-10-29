//
//  SketchViewInterface.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/19/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit

public protocol SketchViewInterface: class {
  func showNoContentInterface()
  func showImage(_ image: UIImage)
  func lockImage()
  func unlockImage()
  func toggleControls()
}
