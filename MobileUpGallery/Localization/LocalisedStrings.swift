//
//  LocalisedStrings.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 30.04.2023.
//

import Foundation

enum ButtonLabels: String {
	case loginButton
	case logout

	var localised: String {
		NSLocalizedString(String(describing: Self.self) + "_\(rawValue)" , comment: "")
	}
}
