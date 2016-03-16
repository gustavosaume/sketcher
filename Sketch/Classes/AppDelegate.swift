//
//  AppDelegate.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/6/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow? = {
    return UIWindow(frame: UIScreen.mainScreen().bounds)
  }()

  let rootWireframe = RootWireframe()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    rootWireframe.installRootViewControllerIntoWindow(window!)
    return true
  }
}
