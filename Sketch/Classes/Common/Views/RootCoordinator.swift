//
//  RootWireframe.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit


protocol ChildCoordinator {
  func start()
}


final class RootCoordinator {

  let navigationController: UINavigationController


  // MARK: Coordinator references

  var sketchCoordinator: SketchCoordinator?
  var imagePickerCoordinator: ImagePickerCoordinator?
  var emptyCoordinator: EmptyViewCoordinator?


  // MARK: - Lifecycle

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }


  // MARK: - Navigation

  func start() {
    presentEmptyView()
  }


  // MARK: - Privates

  fileprivate func presentEmptyView() {
    let coordinator = EmptyViewCoordinator(nav: navigationController)
    coordinator.delegate = self
    coordinator.start()
    emptyCoordinator = coordinator
  }

  fileprivate func presentSketchView(sketch: Sketch? = nil) {
    let coordinator = SketchCoordinator(nav: navigationController, sketch: sketch)
    coordinator.delegate = self
    coordinator.start()
    sketchCoordinator = coordinator
  }

  fileprivate func presentImagePicker() {
    let coordinator = ImagePickerCoordinator(nav: navigationController)
    coordinator.delegate = self
    coordinator.start()
    imagePickerCoordinator = coordinator
  }
}



extension RootCoordinator: EmptyViewCoordinatorProtocol {
  func showImagePicker() {
    presentImagePicker()
  }
}


extension RootCoordinator: SketchCoordinatorProtocol {

}



extension RootCoordinator: ImagePickerCoordinatorProtocol {
  func display(_ sketch: Sketch) {
    imagePickerCoordinator = nil
    presentSketchView(sketch: sketch)
    navigationController.dismiss(animated: true, completion: {
      print("DONE")
    })
  }
}
