//
//  IntEXT.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import Foundation

extension Int {
	
	func convertToDateFromUnix() -> Date {
		Date(timeIntervalSince1970: TimeInterval(self))
	}
}
