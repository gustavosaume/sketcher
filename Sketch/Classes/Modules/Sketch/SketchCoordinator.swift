//
//  SketchCoordinator.swift
//  Sketch
//
//  Created by Gustavo Saume on 11/14/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit



final class SketchCoordinator: ChildCoordinator {
  weak var delegate: SketchCoordinatorProtocol?

  let sketch: Sketch?
  let navigationController: UINavigationController


  // MARK: - Initialization

  init(nav: UINavigationController, sketch: Sketch? = nil) {
    self.sketch = sketch
    self.navigationController = nav
  }


  // MARK: - Publics

  func start() {
    let interactor = SketchInteractor()
    let presenter = SketchPresenter(sketch: sketch)
    let controller = SketchViewController(presenter: presenter, interactor: interactor)

    interactor.coordinator = delegate
    interactor.interface = controller

    configure(navigationItem: controller.navigationItem, interactor: interactor)
    navigationController.viewControllers = [controller]
  }


  // MARK: - Privates

  private func configure(navigationItem: UINavigationItem, interactor: SketchInteractorProtocol) {
    let toggleButton = UIButton()
    toggleButton.setTitle("Lock", for: .normal)
    toggleButton.setTitle("Unlock", for: .selected)
    toggleButton.setTitleColor(toggleButton.tintColor, for: .normal)
    toggleButton.tintColor = .clear
    toggleButton.frame = CGRect(x: 0.0, y: 0.0, width: 58.0, height: 34.0)
    toggleButton.addTarget(interactor, action: #selector(SketchInteractorProtocol.toggleImageLock(sender:)), for: .touchUpInside)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: toggleButton)

    let selectButton = UIButton()
    selectButton.setTitle("New", for: .normal)
    selectButton.setTitleColor(selectButton.tintColor, for: .normal)
    selectButton.sizeToFit()
    selectButton.addTarget(interactor, action: #selector(SketchInteractorProtocol.presentImagePicker), for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: selectButton)
  }
}
