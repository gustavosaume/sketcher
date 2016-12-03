//
//  EmptyViewController.swift
//  Sketch
//
//  Created by Gustavo Saume on 12/3/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import UIKit

final class EmptyViewController: UIViewController {
  let interactor: EmptyViewInteractor

  init(interactor: EmptyViewInteractor) {
    self.interactor = interactor
    super.init(nibName: "EmptyView", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }



  // MARK: - Actions

  @IBAction func selectPhoto(_ sender: UIButton) {
    interactor.openImagePicker()
  }
}
