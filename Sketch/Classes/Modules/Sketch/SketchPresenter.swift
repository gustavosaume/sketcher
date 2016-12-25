//
//  SketchPresenter.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit


protocol SketchPresenterProtocol: class {
  var sketch: Sketch { get }
  var image: UIImage? { get }

  var currentBrightness: Float { get }
  var currentFilters: FiltersBridge { get }

  func update(filters: FiltersBridge)
}


extension SketchPresenterProtocol {
  var currentBrightness: Float {
    return Float(UIScreen.main.brightness)
  }

  var currentFilters: FiltersBridge {
    return FiltersBridge(lineOverlayFilter: sketch.lineOverlayFilter)
  }
}


class SketchPresenter {
  var sketch: Sketch
  let imageComposer = FilterImageComposer()

  var image: UIImage? {
    return imageComposer.compose(image: sketch.image, filters: sketch.filters)
  }

  init(sketch: Sketch) {
    self.sketch = sketch
  }

  func update(filters: FiltersBridge) {
    sketch = Sketch(lineOverlayFilter: filters.lineOverlayFilter, sketch: sketch)
  }
}


extension SketchPresenter: SketchPresenterProtocol {}
