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
  func selectModuleDidSelectImage(_ image: UIImage)
}


class SelectSketchPresenter: NSObject {
  fileprivate(set) var interactor: SelectSketchInteractorProtocol
  weak var selectModuleDelegate: SelectModuleDelegate?

  init(interactor: SelectSketchInteractorProtocol) {
    self.interactor = interactor
  }
}

extension SelectSketchPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    interactor.storeLastOpenedImage(image)
    selectModuleDelegate?.selectModuleDidSelectImage(image)
    picker.dismiss(animated: true) {}
  }
}

extension SelectSketchPresenter: SelectSketchPresenterProtocol {

}
