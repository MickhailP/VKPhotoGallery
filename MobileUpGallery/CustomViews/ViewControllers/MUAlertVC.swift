//
//  MUAlertVC.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 28.04.2023.
//

import UIKit

final class MUAlertVC: UIViewController {

	let containerView = MUAlertContainerView()
	let titleLabel = MUTitleLabel(textAlignment: .center, fontSize: 20)
	let messageLabel = MUBodyLabel(textAlignment: .center)
	let actionButton = MUButton(backgroundColor: .systemMint, title: "Ok")

	var alertTitle: String?
	var message: String?
	var buttonTitle: String?

	var padding: CGFloat = 20

	var completion: (()-> Void)? = nil


	init(title: String, message: String, buttonTitle: String) {
		super.init(nibName: nil, bundle: nil)
		self.alertTitle = title
		self.message = message
		self.buttonTitle = buttonTitle
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor.black.withAlphaComponent(0.6)

		configureContainerView()
		configureTitleLabel()
		configureActionButton()
		configureBodyLabel()
	}


	private func configureContainerView() {
		view.addSubview(containerView)

		containerView.snp.makeConstraints { make in
			make.centerX.centerY.equalToSuperview()
			make.height.equalTo(220)
			make.width.equalTo(280)
		}
	}


	private func configureTitleLabel() {
		containerView.addSubview(titleLabel)

		titleLabel.text = alertTitle ?? "Default title"

		titleLabel.snp.makeConstraints { make in
			make.leading.trailing.equalTo(containerView).inset(padding)
			make.top.equalToSuperview().offset(padding)
			make.height.equalTo(28)
		}
	}


	private func configureActionButton() {
		containerView.addSubview(actionButton)
		actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
		actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

		actionButton.snp.makeConstraints { make in
			make.bottom.equalToSuperview().inset(padding)
			make.leading.trailing.equalToSuperview().inset(padding)
			make.height.equalTo(ViewSize.buttonHeight)
		}
	}


	private func configureBodyLabel() {
		containerView.addSubview(messageLabel)

		messageLabel.text = message ?? "some error occurred"
		messageLabel.numberOfLines = 4

		messageLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.leading.trailing.equalTo(containerView).inset(padding)
			make.bottom.equalTo(actionButton.snp.top).inset(12)
		}
	}


	@objc func dismissVC() {
		dismiss(animated: true)
		if let completion {
			completion()
		}
	}
}
