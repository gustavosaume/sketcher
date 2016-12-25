//
//  OverlayFilter.swift
//  Sketch
//
//  Created by Gustavo Saume on 12/23/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit

protocol CIFilterable {
  var ciFilter: CIFilter { get }
}

struct LineOverlayFilter {
  let noiseLevel: Float  //0.07, 0~0.1
  let sharpness: Float  //0.71 ,0~2
  let edgeIntensity: Float  //1.0 ,0.0~20
  let threshold: Float  //0.1 ,0~1
  let contrast: Float  // 50 ,0.25~200

  init(noiseLevel: Float =  0.07, sharpness: Float = 0.71,
    edgeIntensity: Float = 1.0, threshold: Float = 0.10, contrast: Float = 50.0) {

    self.noiseLevel = noiseLevel
    self.sharpness = sharpness
    self.edgeIntensity = edgeIntensity
    self.threshold = threshold
    self.contrast = contrast
  }

  init(noiseLevel: Float? =  nil, sharpness: Float?  = nil,
    edgeIntensity: Float? = nil, threshold: Float? = nil, contrast: Float? = nil,
    filter: LineOverlayFilter) {

    self.noiseLevel = noiseLevel ?? filter.noiseLevel
    self.sharpness = sharpness ?? filter.sharpness
    self.edgeIntensity = edgeIntensity ?? filter.edgeIntensity
    self.threshold = threshold ?? filter.threshold
    self.contrast = contrast ?? filter.contrast
  }
}


extension LineOverlayFilter: CIFilterable {
  var ciFilter: CIFilter {
    guard let filter = CIFilter(name: "CILineOverlay", withInputParameters: [
      "inputNRNoiseLevel": noiseLevel,
      "inputNRSharpness": sharpness,
      "inputEdgeIntensity": edgeIntensity,
      "inputThreshold": threshold,
      "inputContrast": contrast
    ]) else { fatalError("Could not build line overlay filter") }
    return filter
  }
}
