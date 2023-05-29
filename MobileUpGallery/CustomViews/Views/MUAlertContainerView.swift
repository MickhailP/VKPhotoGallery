//
//  MUAlertContainerView.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 28.04.2023.
//

import UIKit

final class MUAlertContainerView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	private  func configureView() {
		backgroundColor = .systemBackground
		layer.cornerRadius = 16
		layer.borderWidth = 2
		layer.borderColor = UIColor.white.cgColor
		translatesAutoresizingMaskIntoConstraints = false
	}
}
