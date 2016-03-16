//
//  SketchViewController.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import UIKit

class SketchViewController: UIViewController {

  @IBOutlet weak var sketchScrollContainer: UIScrollView!
  @IBOutlet weak var sketchImageView: UIImageView!

  let presenter: SketchPresenterProtocol

  // MARK: - Initializers

  init(presenter: SketchPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: "SketchView", bundle: nil)

    self.automaticallyAdjustsScrollViewInsets = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Needs to call init(presenter:)")
  }


  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar()
    self.view.backgroundColor = UIColor.whiteColor()
  }


  // MARK: - UI Stuff

  private func configureNavBar() {
    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: presenter, action: "presentLoadForm")
    navigationItem.rightBarButtonItem = addButton
  }
}
