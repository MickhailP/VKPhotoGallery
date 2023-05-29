//
//  LoginVC.swift
//  VKPhotoGallery
//
//  Created by Миша Перевозчиков on 27.04.2023.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController, Coordinating {

	var coordinator: Coordinator?

	let loginButton = MUButton(backgroundColor: CustomColors.loginButtonColor ?? .black, title: ButtonLabels.loginButton.localised)
	let titleLabel = MUTitleLabel(textAlignment: .left, fontSize: 44)


	init(coordinator: Coordinator) {
		super.init(nibName: nil, bundle: nil)
		self.coordinator = coordinator
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureTitleLabel()
		configureLoginButton()
	}


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
	}


	private func configureTitleLabel() {
		view.addSubview(titleLabel)
		titleLabel.text = "Mobile Up Gallery"

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(LoginViewTitlePaddings.top)
			make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(LoginViewTitlePaddings.leading)
			make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(LoginViewTitlePaddings.trailing)
		}
	}


	private func configureLoginButton() {
		view.addSubview(loginButton)
		loginButton.translatesAutoresizingMaskIntoConstraints = false
		loginButton.setTitleColor(CustomColors.loginTitleColor, for: .normal) 
		loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)

		let padding: CGFloat = 14

		loginButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(42)
			make.height.equalTo(ViewSize.buttonHeight)
			make.leading.trailing.equalToSuperview().inset(padding)
		}
	}

	@objc func login() {
		coordinator?.presentWebView()
	}
}

