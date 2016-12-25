//
//  SketchViewController.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import UIKit

class SketchViewController: UIViewController {


  // MARK: - Outlets

  @IBOutlet weak var sketchScrollContainer: UIScrollView! {
    didSet {
      sketchScrollContainer.delegate = self
      sketchScrollContainer.maximumZoomScale = 5.0
    }
  }

  @IBOutlet weak var sketchImageView: UIImageView! {
    didSet {
      let tapGesture = UITapGestureRecognizer(target: interactor, action: #selector(SketchInteractorProtocol.toggleControls))
      sketchImageView.addGestureRecognizer(tapGesture)
      sketchImageView.isUserInteractionEnabled = true
    }
  }

  @IBOutlet weak var edgeBarButton: UIBarButtonItem! {
    didSet {
      edgeBarButton.target = interactor
      edgeBarButton.action = #selector(SketchInteractorProtocol.toggleEdgeDetection)
    }
  }

  @IBOutlet weak var brightnessBarButton: UIBarButtonItem! {
    didSet {
      brightnessBarButton.target = interactor
      brightnessBarButton.action = #selector(SketchInteractorProtocol.toggleBrightness)
    }
  }

  @IBOutlet weak var brightnessSlider: UISlider! {
    didSet {
      brightnessSlider.value = presenter.currentBrightness
      brightnessSlider.addTarget(interactor, action: #selector(SketchInteractorProtocol.sliderChanged(brightnessSlider:)), for: .valueChanged)
    }
  }

  @IBOutlet weak var lineOverlayNoiseSlider: UISlider! {
    didSet {
      lineOverlayNoiseSlider.value = presenter.currentFilters.lineOverlayFilter?.noiseLevel ?? 0.07
      lineOverlayNoiseSlider.addTarget(interactor, action: #selector(SketchInteractorProtocol.lineOverlaySliderChanged(noiseSlider:)), for: .valueChanged)
    }
  }

  @IBOutlet weak var lineOverlaySharpnessSlider: UISlider! {
    didSet {
      lineOverlaySharpnessSlider.value = presenter.currentFilters.lineOverlayFilter?.sharpness ?? 0.71
      lineOverlaySharpnessSlider.addTarget(interactor, action: #selector(SketchInteractorProtocol.lineOverlaySliderChanged(sharpnessSlider:)), for: .valueChanged)
    }
  }

  @IBOutlet weak var lineOverlayEdgeIntensitySlider: UISlider! {
    didSet {
      lineOverlayEdgeIntensitySlider.value = presenter.currentFilters.lineOverlayFilter?.edgeIntensity ?? 1.0
      lineOverlayEdgeIntensitySlider.addTarget(interactor, action: #selector(SketchInteractorProtocol.lineOverlaySliderChanged(edgeIntensitySlider:)), for: .valueChanged)
    }
  }

  @IBOutlet weak var lineOverlayThresholdSlider: UISlider! {
    didSet {
      lineOverlayThresholdSlider.value = presenter.currentFilters.lineOverlayFilter?.threshold ?? 0.1
      lineOverlayThresholdSlider.addTarget(interactor, action: #selector(SketchInteractorProtocol.lineOverlaySliderChanged(thresholdSlider:)), for: .valueChanged)
    }
  }

  @IBOutlet weak var lineOverlayContrastSlider: UISlider! {
    didSet {
      lineOverlayContrastSlider.value = presenter.currentFilters.lineOverlayFilter?.contrast ?? 50.0
      lineOverlayContrastSlider.addTarget(interactor, action: #selector(SketchInteractorProtocol.lineOverlaySliderChanged(contrastSlider:)), for: .valueChanged)
    }
  }


  @IBOutlet weak var toolbarBottomDistance: NSLayoutConstraint!

  @IBOutlet weak var brightnessControls: UIView!

  @IBOutlet weak var edgeControls: UIView!


  // MARK: - Public vars

  let interactor: SketchInteractorProtocol
  let presenter: SketchPresenterProtocol

  var toolbarState: ToolbarState = .closed {
    didSet {
      let distance: CGFloat
      switch toolbarState {
      case .closed: distance = 0.0
      case .brightness: distance = 44.0
      case .edge: distance = 242.0
      case .hidden: distance = -44.0
      }

      brightnessControls.isHidden = toolbarState != .brightness
      edgeControls.isHidden = toolbarState != .edge
      toolbarBottomDistance.constant = distance
      UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
        self.view.layoutIfNeeded()
      }, completion: nil)
    }
  }


  // MARK: - Initializers

  init(presenter: SketchPresenterProtocol, interactor: SketchInteractorProtocol) {
    self.presenter = presenter
    self.interactor = interactor

    super.init(nibName: "SketchView", bundle: nil)
    automaticallyAdjustsScrollViewInsets = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Needs to call init(presenter:)")
  }


  // MARK: - Lifecycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    redrawSketch()
  }


  // MARK: - File private behavior

  fileprivate func redrawSketch() {
    DispatchQueue.global(qos: .userInitiated).async {
      let processedImage = self.presenter.image
      DispatchQueue.main.async {
        self.sketchImageView.image = processedImage
      }
    }
  }
}



extension SketchViewController: SketchViewInterface {
  var currentFilters: FiltersBridge {
    return presenter.currentFilters
  }

  func lockImage() {
    sketchScrollContainer.isScrollEnabled = false
    sketchScrollContainer.pinchGestureRecognizer?.isEnabled = false
  }

  func unlockImage() {
    sketchScrollContainer.isScrollEnabled = true
    sketchScrollContainer.pinchGestureRecognizer?.isEnabled = true
  }

  func toggleControls() {
    guard let navigationController = navigationController else { return }
    let showControls = navigationController.isNavigationBarHidden
    navigationController.setNavigationBarHidden(!showControls, animated: true)
    toggleToolbar(visible: showControls)
  }

  func toggleToolbar(visible: Bool) {
    toolbarState = visible ? .closed : .hidden
  }

  func update(filters: FiltersBridge) {
    presenter.update(filters: filters)
    redrawSketch()
  }
}

extension SketchViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return sketchImageView
  }
}
