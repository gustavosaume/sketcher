//
//  SketchWireframe.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/12/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import Foundation
import UIKit


protocol SketchWireframeProtocol: class {
  var presenter: SketchPresenterProtocol? { get set }
  var addWireframe: SelectSketchWireframeProtocol? { get set }

  func presentFromWindow(_ window: UIWindow)
  func presentAddView()
}

class SketchWireframe {
  var presenter: SketchPresenterProtocol?
  var addWireframe: SelectSketchWireframeProtocol?

  lazy var sketchViewController: SketchViewController = {
    guard let presenter = self.presenter else {
      fatalError("SketchPresenter not set")
    }

    return SketchViewController(presenter: presenter)
  }()
}


extension SketchWireframe: SketchWireframeProtocol {
  func presentFromWindow(_ window: UIWindow) {
    let navController = UINavigationController(rootViewController: sketchViewController)
    window.rootViewController = navController
    window.makeKeyAndVisible()
  }

  func presentAddView() {
    addWireframe?.presentFromViewController(sketchViewController)
  }
}
