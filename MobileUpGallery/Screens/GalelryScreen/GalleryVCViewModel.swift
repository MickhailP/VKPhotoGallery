//
//  GalleryVCViewModel.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import Foundation

final class GalleryVCViewModel {

	var coordinator: Coordinator?
	let user: User
	let networkingManager: NetworkingManager

	var photos: [Photo] = []


	init(coordinator: Coordinator? = nil, user: User, networkingManager: NetworkingManager) {
		self.coordinator = coordinator
		self.user = user
		self.networkingManager = networkingManager
	}


	func requestImages(ofOwner owner: String, fromAlbum album: String, completion: @escaping (Result<[Photo], ErrorMessage>) -> Void) {

		let endpoint = "\(VKUrls.apiRequest.rawValue)\(EndpointMethods.getPhotos.rawValue)?owner_id=\(owner)&album_id=\(album)&access_token=\(user.accessToken)&v=5.131"

		print(endpoint)

		guard let url = URL(string: endpoint) else {
			completion(.failure(.badURL))
			return
		}

		Task {
			let result = await self.networkingManager.downloadDataResult(from: url)

			switch result {
				case .success(let data):
					do {
						let decodedData = try JSONDecoder().decode(PhotoResponse.self, from: data)
						let photoItems = decodedData.response.items
						let photos = extractPhotoDataFrom(photoItems)

						completion(.success(photos))

					} catch {
						completion(.failure(.decodingError))
					}
				case .failure:
					completion(.failure(.fetchingError))
			}
		}
	}


	private func extractPhotoDataFrom(_ photoItems: [Item]) -> [Photo] {
		photoItems.forEach { item in
			let date = item.date
			let url = item.sizes.first{ $0.type == .z }?.url ?? "NA"
			let newPhoto = Photo(date: date, photoUrl: url)
			photos.append(newPhoto)
		}
		return photos
	}
}
