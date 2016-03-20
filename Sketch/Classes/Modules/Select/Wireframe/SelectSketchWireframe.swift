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
  func presentFromViewController(viewController: UIViewController)
}


class SelectSketchWireframe {
  let presenter: SelectSketchPresenterProtocol
  private weak var pickerDelegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>?

  init(presenter: SelectSketchPresenterProtocol, pickerDelegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>?) {
    self.presenter = presenter
    self.pickerDelegate = pickerDelegate
  }
}

extension SelectSketchWireframe: SelectSketchWireframeProtocol {
  func presentFromViewController(viewController: UIViewController) {
    let pickerController = UIImagePickerController()
    pickerController.sourceType = .PhotoLibrary
    pickerController.mediaTypes = [kUTTypeImage as String]
    pickerController.allowsEditing = false
    pickerController.delegate = pickerDelegate
    viewController.presentViewController(pickerController, animated: true) {}
  }
}
