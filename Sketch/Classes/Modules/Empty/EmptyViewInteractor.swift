//
//  EmptyViewInteractor.swift
//  Sketch
//
//  Created by Gustavo Saume on 12/3/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation

final class EmptyViewInteractor {
  weak var coordinator: EmptyViewCoordinatorProtocol?

  init(coordinator: EmptyViewCoordinatorProtocol?) {
    self.coordinator = coordinator
  }

  func openImagePicker() {
    coordinator?.showImagePicker()
  }
}
