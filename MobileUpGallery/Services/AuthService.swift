//
//  AuthService.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 27.04.2023.
//

import Foundation


final class AuthService {

	weak var coordinator: MainCoordinator?
	var activeUser: User?
	var isAuthenticated = false

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

	func getUserDataFrom(url: URL) throws {

		var components = URLComponents()
		components.query = url.fragment

		if let items = components.queryItems {

			let accessToken = items.first { $0.name == "access_token"}?.value
			let userID = items.first { $0.name == "user_id"}?.value
			let expiresIn = items.first { $0.name == "expires_in"}?.value

			guard let expiresIn,
				  let seconds = Double(expiresIn),
				  let userID,
				  let accessToken
			else {
				throw ErrorMessage.invalidResponse
			}

			let date = Date.now.addingTimeInterval(seconds)

			let user = User(userID: userID, accessToken: accessToken, tokenExpiringDate: date)

			if KeychainManager.save(user: user) != nil  {
				throw ErrorMessage.activeUserMissing
			}
			activeUser = user
			isAuthenticated = true

		} else {
			throw ErrorMessage.invalidResponse
		}
	}
}
