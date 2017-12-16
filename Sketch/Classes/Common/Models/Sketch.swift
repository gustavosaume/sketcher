//
//  Sketch.swift
//  Sketch
//
//  Created by Gustavo Saume on 11/6/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit
import CoreImage


struct Sketch {

  let image: UIImage
  let lineOverlayFilter: LineOverlayFilter?

  var filters: [CIFilter] {
    return [lineOverlayFilter].flatMap({ $0 as? CIFilterable }).map({ $0.ciFilter })
  }

  init(image: UIImage, lineOverlayFilter: LineOverlayFilter? = nil) {
    self.image = image
    self.lineOverlayFilter = lineOverlayFilter
  }

  init(lineOverlayFilter: LineOverlayFilter? = nil, sketch: Sketch) {
    self.image = sketch.image
    self.lineOverlayFilter = lineOverlayFilter ?? sketch.lineOverlayFilter
  }
}
