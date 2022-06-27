//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 10.06.2022.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private(set) var assembler = Assembler([ModelAssembly(), ViewModelAssembly(), ViewControllerAssembly(), ServiceAssembly()])

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard
            let windowScene = (scene as? UIWindowScene),
            let weatherViewController = assembler.resolver.resolve(WeatherViewController.self)
        else { return }
        
        requestLocation()
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: weatherViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    private func requestLocation() {
        let locationService = assembler.resolver.resolve(LocationServiceContenxt.self)
        switch locationService?.authorizationStatus {
        case .notDetermined:
            locationService?.requestAuthorization()
        default: break
        }
    }
}
