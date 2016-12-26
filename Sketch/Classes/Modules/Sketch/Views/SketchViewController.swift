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
      let tapGesture = UITapGestureRecognizer(target: self.presenter, action: "toggleControls")
      sketchImageView.addGestureRecognizer(tapGesture)
      sketchImageView.userInteractionEnabled = true
    }
  }

  let presenter: SketchPresenterProtocol

  lazy var addBarButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .Add, target: self.presenter, action: "presentLoadForm")
  }()

  lazy var lockBarButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .Pause, target: self.presenter, action: "lockImage")
  }()

  lazy var unlockBarButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .Play, target: self.presenter, action: "unlockImage")
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
    view.backgroundColor = UIColor.whiteColor()
  }
}



extension SketchViewController: SketchViewInterface {
  func showNoContentInterface() {

  }

  func showImage(image: UIImage) {
    sketchImageView.image = image
  }

  func lockImage() {
    sketchScrollContainer.scrollEnabled = false
    sketchScrollContainer.pinchGestureRecognizer?.enabled = false
    navigationItem.leftBarButtonItem = unlockBarButton
  }

  func unlockImage() {
    sketchScrollContainer.scrollEnabled = true
    sketchScrollContainer.pinchGestureRecognizer?.enabled = true
    navigationItem.leftBarButtonItem = lockBarButton
  }

  func toggleControls() {
    guard let navigationController = navigationController else {
      return
    }
    navigationController.setNavigationBarHidden(!navigationController.navigationBarHidden, animated: true)
  }
}

extension SketchViewController: UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return sketchImageView
  }
}
