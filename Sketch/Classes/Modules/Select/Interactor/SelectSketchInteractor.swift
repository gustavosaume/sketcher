//
//  SelectSketchInteractor.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/15/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit

protocol SelectSketchInteractorProtocol {
  func storeLastOpenedImage(image: UIImage)
}

class SelectSketchInteractor {
  weak var output: SelectSketchPresenterProtocol?
}

extension SelectSketchInteractor: SelectSketchInteractorProtocol {
  func storeLastOpenedImage(image: UIImage) {

  }
}
