//
//  WebViewViewModel.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 28.04.2023.
//

import Foundation
import WebKit

final class WebViewViewModel {

	let authService: AuthService
	let coordinator: Coordinator?

	init(authService: AuthService, coordinator: Coordinator) {
		self.authService = authService
		self.coordinator = coordinator
	}

	func preformWebViewRequest(for webView: WKWebView) {
		guard let url = URL(string: authService.authURL) else { return }
		let myRequest = URLRequest(url: url)
		webView.load(myRequest)
	}


	func showGalleryView() throws {
		guard let user = authService.activeUser else {
			throw ErrorMessage.activeUserMissing
		}
		coordinator?.presentGallery(for: user)
	}

	func checkTargetPage(for url: URL) -> Bool {
		let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
		if let components = components {
			if components.path == "/blank.html" {
				return true
			}
		}
		return false
	}
}

