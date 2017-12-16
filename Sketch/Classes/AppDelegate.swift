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

  lazy var navigationController: UINavigationController = {
    let nav = UINavigationController()
    return nav
  }()

  lazy var rootCoordinator: RootCoordinator = {
    let coordinator = RootCoordinator(navigationController: self.navigationController)
    return coordinator
  }()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Fabric.with([Crashlytics.self])
    window?.rootViewController = navigationController
    rootCoordinator.start()
    window?.makeKeyAndVisible()
    return true
  }
}
