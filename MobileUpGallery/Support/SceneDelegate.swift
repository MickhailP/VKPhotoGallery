//
//  SceneDelegate.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 27.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }

		let navVC = UINavigationController()
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = navVC
		window?.makeKeyAndVisible()
		

		let coordinator = MainCoordinator(navigationController: navVC)
		coordinator.start()

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
}
