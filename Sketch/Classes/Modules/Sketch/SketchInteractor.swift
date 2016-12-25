//
//  SketchInteractor.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit


@objc protocol SketchInteractorProtocol: class {
  weak var interface: SketchViewInterface? { get set }

  @objc func presentImagePicker()
  @objc func toggleImageLock(sender: UIButton)
  @objc func toggleControls()

  @objc func toggleEdgeDetection()
  @objc func toggleBrightness()

  @objc func sliderChanged(brightnessSlider: UISlider)

  @objc func lineOverlaySliderChanged(noiseSlider: UISlider)
  @objc func lineOverlaySliderChanged(sharpnessSlider: UISlider)
  @objc func lineOverlaySliderChanged(edgeIntensitySlider: UISlider)
  @objc func lineOverlaySliderChanged(thresholdSlider: UISlider)
  @objc func lineOverlaySliderChanged(contrastSlider: UISlider)
}

protocol SketchCoordinatorProtocol: class {
  func showImagePicker()
}



class SketchInteractor {
  weak var interface: SketchViewInterface?
  weak var coordinator: SketchCoordinatorProtocol?
}

extension SketchInteractor: SketchInteractorProtocol {
  public func presentImagePicker() {
    coordinator?.showImagePicker()
  }

  public func toggleImageLock(sender: UIButton) {
    let shouldUnlock = sender.isSelected
    if shouldUnlock {
      interface?.unlockImage()
    } else {
      interface?.lockImage()
    }

    sender.isSelected = !shouldUnlock
  }

  public func toggleControls() {
    interface?.toggleControls()
  }

  public func toggleEdgeDetection() {
    guard let interface = interface else { return }

    let state: ToolbarState = interface.toolbarState == .edge ? .closed : .edge
    interface.toolbarState = state
  }

  public func toggleBrightness() {
    guard let interface = interface else { return }

    let state: ToolbarState = interface.toolbarState == .brightness ? .closed : .brightness
    interface.toolbarState = state
  }


  // MARK: - Brightness

  @objc func sliderChanged(brightnessSlider: UISlider) {
    let value = brightnessSlider.value
    UIScreen.main.wantsSoftwareDimming = false
    UIScreen.main.brightness = CGFloat(value)
  }


  // MARK: - Line overlay

  @objc func lineOverlaySliderChanged(noiseSlider: UISlider) {
    let filters = interface?.currentFilters ?? FiltersBridge()
    let lineOverlayFilter = filters.lineOverlayFilter ?? LineOverlayFilter()
    let noise = noiseSlider.value
    filters.lineOverlayFilter = LineOverlayFilter(noiseLevel: noise, filter: lineOverlayFilter)
    interface?.update(filters: filters)
  }

  @objc func lineOverlaySliderChanged(sharpnessSlider: UISlider) {
    let filters = interface?.currentFilters ?? FiltersBridge()
    let lineOverlayFilter = filters.lineOverlayFilter ?? LineOverlayFilter()
    let sharpness = sharpnessSlider.value
    filters.lineOverlayFilter = LineOverlayFilter(sharpness: sharpness, filter: lineOverlayFilter)
    interface?.update(filters: filters)
  }

  @objc func lineOverlaySliderChanged(edgeIntensitySlider: UISlider) {
    let filters = interface?.currentFilters ?? FiltersBridge()
    let lineOverlayFilter = filters.lineOverlayFilter ?? LineOverlayFilter()
    let edgeIntensity = edgeIntensitySlider.value
    filters.lineOverlayFilter = LineOverlayFilter(edgeIntensity: edgeIntensity, filter: lineOverlayFilter)
    interface?.update(filters: filters)
  }

  @objc func lineOverlaySliderChanged(thresholdSlider: UISlider) {
  let filters = interface?.currentFilters ?? FiltersBridge()
    let lineOverlayFilter = filters.lineOverlayFilter ?? LineOverlayFilter()
    let threshold = thresholdSlider.value
    filters.lineOverlayFilter = LineOverlayFilter(threshold: threshold, filter: lineOverlayFilter)
    interface?.update(filters: filters)
  }

  @objc func lineOverlaySliderChanged(contrastSlider: UISlider) {
    let filters = interface?.currentFilters ?? FiltersBridge()
    let lineOverlayFilter = filters.lineOverlayFilter ?? LineOverlayFilter()
    let contrast = contrastSlider.value
    filters.lineOverlayFilter = LineOverlayFilter(contrast: contrast, filter: lineOverlayFilter)
    interface?.update(filters: filters)
  }
}
