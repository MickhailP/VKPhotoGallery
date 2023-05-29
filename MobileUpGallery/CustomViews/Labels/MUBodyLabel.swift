//
//  MUBodyLabel.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 28.04.2023.
//

import UIKit

final class MUBodyLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
	}


	private func configure() {
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		font = UIFont.preferredFont(forTextStyle: .body)
		adjustsFontForContentSizeCategory = true
		minimumScaleFactor = 0.75
		lineBreakMode = .byWordWrapping
		numberOfLines = 0
		translatesAutoresizingMaskIntoConstraints = false
	}
}
