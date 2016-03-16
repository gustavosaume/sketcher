//
//  SketchPresenter.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation

protocol SketchPresenterProtocol: class {
  func presentLoadForm()
}

class SketchPresenter {
  private(set) var interactor: SketchInteractorProtocol

  init(interactor: SketchInteractorProtocol) {
    self.interactor = interactor
  }
}

extension SketchPresenter: SketchPresenterProtocol {
  func presentLoadForm() {
    print("ALERT")
  }
}