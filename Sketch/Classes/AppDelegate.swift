//
//  AppDelegate.swift
//  Sketch
//
//  Created by Gustavo Saume on 3/6/16.
//  Copyright © 2016 BigPanza. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow? = {
    return UIWindow(frame: UIScreen.main.bounds)
  }()

  let rootWireframe = RootWireframe()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Fabric.with([Crashlytics.self])
    rootWireframe.installRootViewControllerIntoWindow(window!)
    return true
  }
}
