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
  var image: UIImage? { get }
}

class SketchPresenter {
  let sketch: Sketch?

  var image: UIImage? {
    return sketch?.processedImage
  }

  init(sketch: Sketch? = nil) {
    self.sketch = sketch
  }
}

extension SketchPresenter: SketchPresenterProtocol {}