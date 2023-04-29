//
//  ErrorMessage.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 28.04.2023.
//

import Foundation

enum ErrorMessage: String, Error {
	case invalidResponse = "Try again"
	case invalidData = "Data is missing"
	case decodingError = "Decoding error"
	case encodingError = "Data cannot be encoded"
	case activeUserMissing = "Active user is missing"
	case authorisationError = "Authorisation failed"
}
