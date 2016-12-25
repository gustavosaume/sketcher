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

  var processedImage: UIImage {
    let ciImage = CIImage(image: image)
    let processedImageImage = filters.reduce(ciImage) { (image, filter) in
      filter.setValue(image, forKey: kCIInputImageKey)
      return filter.outputImage
    }

    guard let composedImage = processedImageImage else { return image }

    let oglContext = EAGLContext(api: .openGLES2)
    let context = CIContext(eaglContext: oglContext!)
    guard let finalImage = context.createCGImage(composedImage, from: composedImage.extent) else {
      return image
    }

    return UIImage(cgImage: finalImage)
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
