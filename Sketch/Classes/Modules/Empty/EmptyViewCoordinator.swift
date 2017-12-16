//
//  EmptyViewCoordinator.swift
//  Sketch
//
//  Created by Gustavo Saume on 12/3/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit



protocol EmptyViewCoordinatorProtocol: class {
  func showImagePicker()
}


final class EmptyViewCoordinator: ChildCoordinator {
  weak var delegate: EmptyViewCoordinatorProtocol?

  let navigationController: UINavigationController


  init(nav: UINavigationController) {
    self.navigationController = nav
  }

  func start() {
    let interactor = EmptyViewInteractor(coordinator: delegate)
    let controller = EmptyViewController(interactor: interactor)
    navigationController.viewControllers = [controller]
  }
}

