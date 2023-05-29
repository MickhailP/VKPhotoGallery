//
//  KeychainManager.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 27.04.2023.
//

import Foundation


final class KeychainManager{

	static func retrieveUser(completion: @escaping (Result<User, ErrorMessage>) -> Void) {

		let fetchedData = KeychainWrapper.standard.data(forKey: KeychainKeys.userKey)

		guard let fetchedData else {
			completion(.failure(.dataIsMissing))
			return
		}

		do {
			let decodedUser = try JSONDecoder().decode(User.self, from: fetchedData)
			completion(.success(decodedUser))
		} catch  {
			completion(.failure(.decodingError))
		}
	}


	static func save(user: User) -> ErrorMessage? {
		do {
			let encodedUser = try JSONEncoder().encode(user)
			KeychainWrapper.standard.set(encodedUser, forKey: KeychainKeys.userKey)
			return nil
		} catch {
			return .encodingError
		}
	}
}
