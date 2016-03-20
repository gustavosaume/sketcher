//
//  RootWireframe.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/10/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe {

  let sketchWireframe: SketchWireframeProtocol

  init() {
    let selectInteractor = SelectSketchInteractor()
    let selectPresenter = SelectSketchPresenter(interactor: selectInteractor)
    selectInteractor.output = selectPresenter
    let selectWireframe = SelectSketchWireframe(presenter: selectPresenter, pickerDelegate: selectPresenter)

    sketchWireframe = SketchWireframe()
    let sketchInteractor = SketchInteractor()
    let sketchPresenter = SketchPresenter(wireframe: sketchWireframe, interactor: sketchInteractor)
    sketchInteractor.output = sketchPresenter
    sketchWireframe.presenter = sketchPresenter
    sketchWireframe.addWireframe = selectWireframe

    selectPresenter.selectModuleDelegate = sketchPresenter
  }

  func installRootViewControllerIntoWindow(window: UIWindow) {
    sketchWireframe.presentFromWindow(window)
  }
}
