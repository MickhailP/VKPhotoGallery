//
//  UIViewControllerExtension.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 28.04.2023.
//

import UIKit


extension UIViewController {

	func presentAlertOnMainTread(title: String, message: String, buttonTitle: String, completion: (()-> Void)? = nil) {
		DispatchQueue.main.async {
			let alertVC = MUAlertVC(title: title, message: message, buttonTitle: buttonTitle)

			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve

			alertVC.completion = completion

			self.present(alertVC, animated: true)
		}
	}


	 func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
		containerView.layer.masksToBounds = true
	}
}
