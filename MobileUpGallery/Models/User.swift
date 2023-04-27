//
//  User.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 27.04.2023.
//

import Foundation

struct User: Codable {
	let userID: String
	let accessToken: String
	let tokenExpiringDate: Date
}

