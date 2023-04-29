//
//  UIHelper.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import Foundation

import UIKit

struct UIHelper {

	static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
		let width = view.frame.width
		let padding: CGFloat = 10

		let availableWidth = width - (padding * 3)
		let itemWidth = availableWidth / 2

		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)

		return flowLayout
	}
}