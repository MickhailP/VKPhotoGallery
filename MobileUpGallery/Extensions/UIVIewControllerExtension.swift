//
//  UIViewControllerExtension.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 28.04.2023.
//

import UIKit


extension UIViewController {

	func presentGFAlertOnMainTread(title: String, message: String, buttonTitle: String, completion: (()-> Void)? = nil) {
		DispatchQueue.main.async {
			let alertVC = MUAlertVC(title: title, message: message, buttonTitle: buttonTitle)

			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve

			alertVC.completion = completion

			self.present(alertVC, animated: true)
		}
	}
}
