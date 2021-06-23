//
//  AppDelegate.swift
//  Healios
//
//  Created by Чингиз Куандык on 28.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupWindow()
        makeCoordinator(application: application)
        LoggerConfigurator.configure()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CoordinatorNavigationController(backBarButtonImage: nil)
        window?.makeKeyAndVisible()
    }
    
    func makeCoordinator(application: UIApplication) {
        guard let rootController = application.windows.first?.rootViewController as? CoordinatorNavigationController else {
            fatalError("rootViewController must be CoordinatorNavigationController")
        }
        
        appCoordinator = AppCoordinator(router: Router(rootController: rootController), container: assembler.resolver)
        appCoordinator?.start()
    }
}

