//
//  PhotoVC.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import UIKit
import SnapKit


final class PhotoVC: UIViewController {

	let imageView = MUImageView(frame: .zero)
	
	let photo: Photo


	init(photo: Photo) {
		self.photo = photo
		super.init(nibName: nil, bundle: nil)
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavigation(date: photo.date.convertToDateFromUnix())
		configureImageView(with: photo.photoUrl)
    }

	private func configureNavigation(date: Date) {
		self.title = date.convertToDayMonthYearFormat()

		view.backgroundColor = .systemBackground

		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.titleView?.sizeToFit()


		let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhoto))
		self.navigationItem.rightBarButtonItem = shareButton
	}


	private func configureImageView(with imageURL: String) {
		view.addSubview(imageView)

		imageView.getImage(from: imageURL)

		imageView.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(view.snp.width)
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview()
		}
	}

	@objc func sharePhoto() {
		configureActivityVC()
	}

	private func configureActivityVC() {
		guard let image = imageView.image, image != Images.placeholder else {
			presentGFAlertOnMainTread(title: "Error", message: ErrorMessage.imageIsEmpty.rawValue, buttonTitle: "Ok")
			return
		}

		let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		self.present(activityVC, animated: true)
	}
}
