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
      let tapGesture = UITapGestureRecognizer(target: self.presenter, action: #selector(SketchPresenter.toggleControls))
      sketchImageView.addGestureRecognizer(tapGesture)
      sketchImageView.isUserInteractionEnabled = true
    }
  }

  let presenter: SketchPresenterProtocol

  lazy var addBarButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .add, target: self.presenter, action: #selector(SketchPresenter.presentLoadForm))
  }()

  lazy var lockBarButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .pause, target: self.presenter, action: #selector(SketchPresenter.lockImage))
  }()

  lazy var unlockBarButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .play, target: self.presenter, action: #selector(SketchPresenter.unlockImage))
  }()


  // MARK: - Initializers

  init(presenter: SketchPresenterProtocol) {
    self.presenter = presenter

    super.init(nibName: "SketchView", bundle: nil)

    self.presenter.sketchInterface = self
    self.automaticallyAdjustsScrollViewInsets = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Needs to call init(presenter:)")
  }


  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = addBarButton
    navigationItem.leftBarButtonItem = lockBarButton
    view.backgroundColor = UIColor.white
  }
}



extension SketchViewController: SketchViewInterface {
  func showNoContentInterface() {

  }

  func showImage(_ image: UIImage) {
    sketchImageView.image = image
  }

  func lockImage() {
    sketchScrollContainer.isScrollEnabled = false
    sketchScrollContainer.pinchGestureRecognizer?.isEnabled = false
    navigationItem.leftBarButtonItem = unlockBarButton
  }

  func unlockImage() {
    sketchScrollContainer.isScrollEnabled = true
    sketchScrollContainer.pinchGestureRecognizer?.isEnabled = true
    navigationItem.leftBarButtonItem = lockBarButton
  }

  func toggleControls() {
    guard let navigationController = navigationController else {
      return
    }
    navigationController.setNavigationBarHidden(!navigationController.isNavigationBarHidden, animated: true)
  }
}

extension SketchViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return sketchImageView
  }
}
