//
//  PhotoResponse.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import Foundation

struct PhotoResponse: Decodable {
	let response: Response
}

// MARK: - Response
struct Response: Codable {
	let count: Int
	let items: [Item]
}

// MARK: - Item
struct Item: Codable {
	let albumID, date, id, ownerID: Int
	let sizes: [Size]
	let text: String
	let userID: Int
	let hasTags: Bool

	enum CodingKeys: String, CodingKey {
		case albumID = "album_id"
		case date, id
		case ownerID = "owner_id"
		case sizes, text
		case userID = "user_id"
		case hasTags = "has_tags"
	}
}

// MARK: - Size
struct Size: Codable {
	let height: Int
	let type: TypeEnum
	let width: Int
	let url: String
}

enum TypeEnum: String, Codable {
	case m = "m"
	case o = "o"
	case p = "p"
	case q = "q"
	case r = "r"
	case s = "s"
	case w = "w"
	case x = "x"
	case y = "y"
	case z = "z"
}

