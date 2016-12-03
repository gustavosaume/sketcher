//
//  SketchInteractor.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation


@objc
protocol SketchInteractorProtocol {
  weak var interface: SketchViewInterface? { get set }

  func presentImagePicker()
  func lockImage()
  func unlockImage()
  func toggleControls()
}

protocol SketchCoordinatorProtocol: class {

}



class SketchInteractor {
  weak var interface: SketchViewInterface?
  weak var coordinator: SketchCoordinatorProtocol?
}

extension SketchInteractor: SketchInteractorProtocol {
  public func presentImagePicker() {
//    coordinator?.showImagePicker()
  }

  public func lockImage() {
    interface?.lockImage()
  }

  public func unlockImage() {
    interface?.unlockImage()
  }

  public func toggleControls() {
    interface?.toggleControls()
  }
}
