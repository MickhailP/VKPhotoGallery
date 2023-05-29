//
//  PhotoVCViewModel.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 30.04.2023.
//

import UIKit


protocol HorizontalGalleryDelegate: AnyObject {
	func presentPhotoOnScreen(_ photo: UIImage)
}


final class HorizontalGalleryViewModel {

	var photos: [Photo] = []
	
	weak var delegate: HorizontalGalleryDelegate?

	init(photos: [Photo], delegate: HorizontalGalleryDelegate) {
		self.photos = photos
		self.delegate = delegate
	}


	func show(_ photo: UIImage) {
		delegate?.presentPhotoOnScreen(photo)
	}
}
