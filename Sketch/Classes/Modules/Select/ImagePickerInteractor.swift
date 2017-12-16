//
//  SelectSketchInteractor.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/15/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit


protocol ImagePickerCoordinatorProtocol: class {
  func display(_ sketch: Sketch)
}


protocol ImagePickerInteractorProtocol {}

class ImagePickerInteractor: NSObject {
  weak var coordinator: ImagePickerCoordinatorProtocol?
}


extension ImagePickerInteractor: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    let sketch = Sketch(image: image)
    coordinator?.display(sketch)
  }
}
