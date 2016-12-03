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

  init(nav: UINavigationController, sketch: Sketch? = nil) {
    self.sketch = sketch
    self.navigationController = nav
  }

  func start() {
    let presenter = SketchPresenter(sketch: sketch)
    let interactor = SketchInteractor()
    let controller = SketchViewController(presenter: presenter, interactor: interactor)

    interactor.coordinator = delegate
    interactor.interface = controller

    navigationController.viewControllers = [controller]
  }
}
