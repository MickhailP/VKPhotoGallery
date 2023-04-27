//
//  AuthService.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 27.04.2023.
//

import Foundation


struct VKAppID {
	static let identifier = "51625739"
	static let albumOwner = "-128666765"
	static let albumId = "266310117"
}


final class AuthService {

	weak var coordinator: MainCoordinator?
	var activeUser: User?

	let authURL = "https://oauth.vk.com/authorize?client_id=\(VKAppID.identifier)&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&response_type=token&v=5.131"


	init(coordinator: MainCoordinator? = nil) {
		self.coordinator = coordinator
	}


	func performAuthorization() {

		KeychainManager.retrieveUser { [weak self] result in

			guard let self = self else { return }

			switch result {
				case .success(let user):

					if Date.now >= user.tokenExpiringDate {
						self.coordinator?.presentLoginView()
					} else {
						self.coordinator?.presentGallery(for: user)
					}

				case .failure:
					self.coordinator?.presentLoginView()
			}
		}
	}


	func checkIsAuthorisationFinished(for url: URL) -> Bool {

		let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
		if let components = components {
			if components.path == "/blank.html" {
				getUserDataFrom(url: url)
				return true
			}
		}
		return false
	}


	private func getUserDataFrom(url: URL) {

		var components = URLComponents()
		components.query = url.fragment

		if let items = components.queryItems {

			let accessToken = items.first { $0.name == "access_token"}?.value
			let userID = items.first { $0.name == "user_id"}?.value
			let expiresIn = items.first { $0.name == "expires_in"}?.value


			guard let expiresIn else { return }
			guard let seconds = Double(expiresIn) else { return }
			let date = Date.now.addingTimeInterval(seconds)

			if let userID, let accessToken {
				let user = User(userID: userID, accessToken: accessToken, tokenExpiringDate: date)

				KeychainManager.save(user: user)
				activeUser = user
			}
		}
	}
}
