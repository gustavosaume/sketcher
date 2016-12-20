//
//  SketchViewController.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import UIKit

class SketchViewController: UIViewController {

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

  @IBOutlet weak var toolbarBottomDistance: NSLayoutConstraint!

  @IBOutlet weak var brightnessControls: UIView!

  @IBOutlet weak var edgeControls: UIView!

  let interactor: SketchInteractorProtocol
  let presenter: SketchPresenterProtocol

  var toolbarState: ToolbarState = .closed {
    didSet {
      let distance: CGFloat
      switch toolbarState {
      case .closed: distance = 0.0
      case .brightness: distance = 44.0
      case .edge: distance = 44.0
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

    DispatchQueue.global(qos: .userInitiated).async {
      let processedImage = self.presenter.image
      DispatchQueue.main.async {
        self.sketchImageView.image = processedImage
      }
    }
  }
}



extension SketchViewController: SketchViewInterface {
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
}

extension SketchViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return sketchImageView
  }
}
