//
//  PhotoCell.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import UIKit
import SnapKit

final class PhotoCell: UICollectionViewCell {

	var photoImageView = MUImageView(frame: .zero)


	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func prepareForReuse() {
		super.prepareForReuse()
		photoImageView.image = photoImageView.placeholderImage

	}


	func set(photo: Photo) {
		photoImageView.getImage(from: photo.photoUrl)
	}

	private func configure() {
		self.addSubview(photoImageView)
		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		clipsToBounds = true
		photoImageView.sizeToFit()


		photoImageView.snp.makeConstraints { make in
			make.top.leading.trailing.bottom.equalToSuperview().inset(0)
		}
	}
}
