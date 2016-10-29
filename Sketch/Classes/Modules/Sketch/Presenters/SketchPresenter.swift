//
//  SketchPresenter.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit

public protocol SketchPresenterProtocol: class {
  weak var sketchInterface: SketchViewInterface? { get set }
  func presentLoadForm()
  func lockImage()
  func unlockImage()
  func toggleControls()
}

open class SketchPresenter: NSObject {
  fileprivate let interactor: SketchInteractorProtocol
  fileprivate let wireframe: SketchWireframeProtocol
  open weak var sketchInterface: SketchViewInterface?

  init(wireframe: SketchWireframeProtocol, interactor: SketchInteractorProtocol) {
    self.interactor = interactor
    self.wireframe = wireframe
  }
}

extension SketchPresenter: SketchPresenterProtocol {
  public func presentLoadForm() {
    wireframe.presentAddView()
  }

  public func lockImage() {
    sketchInterface?.lockImage()
  }

  public func unlockImage() {
    sketchInterface?.unlockImage()
  }

  public func toggleControls() {
    sketchInterface?.toggleControls()
  }
}

extension SketchPresenter: SelectModuleDelegate {
 func selectModuleDidSelectImage(_ image: UIImage) {
    sketchInterface?.showImage(image)
  }
}
