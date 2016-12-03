//
//  ImagePickerCoordinator.swift
//  Sketch
//
//  Created by Gustavo Saume on 11/14/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices



final class ImagePickerCoordinator: ChildCoordinator {
  weak var delegate: ImagePickerCoordinatorProtocol?

  let interactor = ImagePickerInteractor()
  let navigationController: UINavigationController

  init(nav: UINavigationController) {
    self.navigationController = nav
  }

  func start() {
    interactor.coordinator = delegate
    let pickerController = UIImagePickerController()
    pickerController.delegate = interactor
    pickerController.sourceType = .photoLibrary
    pickerController.mediaTypes = [kUTTypeImage as String]
    pickerController.allowsEditing = false

    navigationController.present(pickerController, animated: true, completion: nil)
  }
}
