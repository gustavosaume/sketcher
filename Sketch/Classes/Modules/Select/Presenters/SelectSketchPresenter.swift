//
//  SelectPresenter.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/15/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit

protocol SelectSketchPresenterProtocol: class {

}

protocol SelectModuleDelegate: class {
  func selectModuleDidSelectImage(image: UIImage)
}


class SelectSketchPresenter: NSObject {
  private(set) var interactor: SelectSketchInteractorProtocol
  weak var selectModuleDelegate: SelectModuleDelegate?

  init(interactor: SelectSketchInteractorProtocol) {
    self.interactor = interactor
  }
}

extension SelectSketchPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    interactor.storeLastOpenedImage(image)
    selectModuleDelegate?.selectModuleDidSelectImage(image)
    picker.dismissViewControllerAnimated(true) {}
  }
}

extension SelectSketchPresenter: SelectSketchPresenterProtocol {

}
