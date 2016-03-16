//
//  SelectPresenter.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/15/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation

protocol SelectSketchPresenterProtocol: class {

}

class SelectSketchPresenter {
  private(set) var interactor: SelectSketchInteractorProtocol

  init(interactor: SelectSketchInteractorProtocol) {
    self.interactor = interactor
  }
}

extension SelectSketchPresenter: SelectSketchPresenterProtocol {

}
