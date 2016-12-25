//
//  FilterImageComposer.swift
//  Sketch
//
//  Created by Gustavo Saume on 12/25/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import UIKit

struct FilterImageComposer {
  let context: CIContext = {
    let oglContext = EAGLContext(api: .openGLES2)
    return CIContext(eaglContext: oglContext!)
  }()

  func compose(image: UIImage, filters: [CIFilter]) -> UIImage {
    guard let ciImage = CIImage(image: image) else { return image }
    guard let composedImage = applyFilters(ciImage: ciImage, filters: filters) else { return image }
    guard let finalImage = context.createCGImage(composedImage, from: composedImage.extent) else { return image }
    return UIImage(cgImage: finalImage)
  }

  private func applyFilters(ciImage: CIImage, filters: [CIFilter]) -> CIImage? {
     return filters.reduce(ciImage) { (image, filter) in
      filter.setValue(image, forKey: kCIInputImageKey)
      return filter.outputImage ?? image
    }
  }
}
