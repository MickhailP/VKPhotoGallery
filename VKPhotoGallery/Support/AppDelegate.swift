//
//  AppDelegate.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 27.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		configureNavigationBarAppearance()
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		
	}

	func configureNavigationBarAppearance() {
		let navBar = UINavigationBar()

		UINavigationBar.appearance().tintColor = CustomColors.loginButtonColor

		let standardAppearance = UINavigationBarAppearance()
		standardAppearance.configureWithOpaqueBackground()

		let compactAppearance = standardAppearance.copy()

		navBar.standardAppearance = standardAppearance
		navBar.scrollEdgeAppearance = standardAppearance
		navBar.compactAppearance = compactAppearance
	}
}

