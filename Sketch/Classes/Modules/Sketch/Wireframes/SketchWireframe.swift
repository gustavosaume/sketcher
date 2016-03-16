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
  var presenter: SketchPresenterProtocol! { get }

  func presentFromWindow(window: UIWindow)
  func presentAddView()
}

class SketchWireframe {
  let presenter: SketchPresenterProtocol!

  init(presenter: SketchPresenterProtocol) {
    self.presenter = presenter
  }
}


extension SketchWireframe: SketchWireframeProtocol {
  func presentFromWindow(window: UIWindow) {
    let rootViewController = SketchViewController(presenter: presenter)
    let navController = UINavigationController(rootViewController: rootViewController)
    window.rootViewController = navController
    window.makeKeyAndVisible()
  }

  func presentAddView() {

  }
}
