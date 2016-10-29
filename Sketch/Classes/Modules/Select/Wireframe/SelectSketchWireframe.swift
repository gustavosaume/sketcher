//
//  SelectWireframe.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/15/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

protocol SelectSketchWireframeProtocol {
  var presenter: SelectSketchPresenterProtocol { get }
  func presentFromViewController(_ viewController: UIViewController)
}


class SelectSketchWireframe {
  let presenter: SelectSketchPresenterProtocol
  fileprivate weak var pickerDelegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?

  init(presenter: SelectSketchPresenterProtocol, pickerDelegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?) {
    self.presenter = presenter
    self.pickerDelegate = pickerDelegate
  }
}

extension SelectSketchWireframe: SelectSketchWireframeProtocol {
  func presentFromViewController(_ viewController: UIViewController) {
    let pickerController = UIImagePickerController()
    pickerController.sourceType = .photoLibrary
    pickerController.mediaTypes = [kUTTypeImage as String]
    pickerController.allowsEditing = false
    pickerController.delegate = pickerDelegate
    viewController.present(pickerController, animated: true) {}
  }
}
