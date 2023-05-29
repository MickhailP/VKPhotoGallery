//
//  DateEXT.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import Foundation

extension Date {

	func convertToDayMonthYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "d MMM yyyy"

		return dateFormatter.string(from: self)
	}
}
