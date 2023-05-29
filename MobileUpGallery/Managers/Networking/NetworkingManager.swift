//
//  NetworkingManager.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import Foundation
import UIKit

final class NetworkingManager {

	private let cache = NSCache<NSString, UIImage>()

	
	func downloadDataResult(from url: URL?) async -> Result<Data,Error> {

		guard let url = url else {
			return .failure( URLError(.badURL))
		}

		do {
			let (data, response) = try await URLSession.shared.data(from: url)
			try handleResponse(response)
			return .success(data)
		} catch {
			print(error)
			print("There was an error during data fetching! ", error.localizedDescription)
			return .failure(error)
		}
	}


	func downloadImage(from url: String) async -> UIImage? {

		if let cachedImage = self.cache.object(forKey: NSString(string: url)) {
			return cachedImage
		} else if let fetchedImage = await fetchImage(from: url) {
			self.cache.setObject(fetchedImage, forKey: NSString(string: url))
			return fetchedImage
		}

		return nil
	}


	func fetchImage(from urlString: String) async -> UIImage? {
		guard let url = URL(string: urlString) else   {
			return nil
		}

		do {
			let (data, response) = try await URLSession.shared.data(from: url)
			try handleResponse(response)
			return UIImage(data: data)
		} catch  {
			print(error)
			return nil
		}
	}


	/// Check if URLResponse have good status code, if it's not, it will throw an error
	/// - Parameter response: URLResponse from dataTask
	private func handleResponse(_ response: URLResponse) throws {

		guard let response = response as? HTTPURLResponse else {
			throw NetworkingError.badURLResponse
		}
		if  response.statusCode >= 200 && response.statusCode <= 300 {
			return
		} else {
			throw NetworkingError.error(response.statusCode)
		}
	}
}
