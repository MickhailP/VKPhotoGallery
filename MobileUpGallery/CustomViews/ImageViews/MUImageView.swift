//
//  MUImageView.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import UIKit

final class MUImageView: UIImageView {

	let placeholderImage = Images.placeholder


	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	private func configure() {
		clipsToBounds = true
		contentMode = .scaleAspectFill

		if let placeholderImage {
			image = placeholderImage
		
		}
		translatesAutoresizingMaskIntoConstraints = false
	}


	func getImage(from url: String) {
		Task {
			if let image = await NetworkingManager().downloadImage(from: url) {
				await MainActor.run {
					self.image = image
				}
			}
		}
	}
}
