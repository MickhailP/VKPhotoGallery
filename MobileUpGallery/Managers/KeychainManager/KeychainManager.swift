//
//  KeychainManager.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 27.04.2023.
//

import Foundation


final class KeychainManager{

	enum SaveKeys {
		static let user = "user"
	}


	static func retrieveUser(completion: @escaping (Result<User, Error>) -> Void) {

	}


	static func save(user: User) {

	}
}
