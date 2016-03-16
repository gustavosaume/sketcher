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
    let sketchInteractor = SketchInteractor()
    let sketchPresenter = SketchPresenter(interactor: sketchInteractor)
    sketchInteractor.output = sketchPresenter

    sketchWireframe = SketchWireframe(presenter: sketchPresenter)

    
  }

  func installRootViewControllerIntoWindow(window: UIWindow) {
    sketchWireframe.presentFromWindow(window)
  }
}
