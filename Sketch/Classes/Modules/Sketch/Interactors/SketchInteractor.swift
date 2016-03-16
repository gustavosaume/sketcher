//
//  SketchInteractor.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation


protocol SketchInteractorProtocol {}

class SketchInteractor {
  weak var output: SketchPresenterProtocol?
}

extension SketchInteractor: SketchInteractorProtocol {

}
