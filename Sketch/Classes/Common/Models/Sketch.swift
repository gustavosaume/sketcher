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
  let filters: [CIFilter]

  var processedImage: UIImage {
    let ciImage = CIImage(image: image)
    let processedImageImage = filters.reduce(ciImage) { (image, filter) in
      filter.setValue(image, forKey: kCIInputImageKey)
      return filter.outputImage
    }

    guard let composedImage = processedImageImage else { return image }

    //let oglContext = EAGLContext(api: .openGLES2)
    //let context = CIContext(eaglContext: oglContext!)
    let context = CIContext(options: nil)
    guard let finalImage = context.createCGImage(composedImage, from: composedImage.extent) else {
      return image
    }

    return UIImage(cgImage: finalImage)
  }
}
