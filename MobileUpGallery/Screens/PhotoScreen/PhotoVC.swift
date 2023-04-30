//
//  PhotoVC.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import UIKit
import SnapKit


final class PhotoVC: UIViewController {

	private let imageView = MUImageView(frame: .zero)
	private let horizontalGallery = UIView()
	private var initialImageWidth: CGFloat?
	private let pinch = UIPinchGestureRecognizer()


	private let photo: Photo
	private var photos: [Photo]


	init(photo: Photo, photos: [Photo]) {
		self.photo = photo
		self.photos = photos
		super.init(nibName: nil, bundle: nil)
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		configureNavigation(date: photo.date.convertToDateFromUnix())
		configureImageView(with: photo.photoUrl)
		configureHorizontalGallery()

		addPinchToZoom()
	}


	private func configureNavigation(date: Date) {
		title = date.convertToDayMonthYearFormat()

		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.titleView?.sizeToFit()
		navigationItem.backButtonDisplayMode = .minimal

		let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhoto))
		navigationItem.rightBarButtonItem = shareButton
	}


	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		initialImageWidth = imageView.frame.width
	}


	private func configureImageView(with imageURL: String) {
		view.addSubview(imageView)

		imageView.getImage(from: imageURL)
		imageView.isUserInteractionEnabled = true

		imageView.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(view.snp.width)
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview()
		}
	}


	private func configureHorizontalGallery() {
		view.addSubview(horizontalGallery)
		horizontalGallery.translatesAutoresizingMaskIntoConstraints = false

		let horizontalGalleryVC = HorizontalGalleryVC(viewModel: HorizontalGalleryViewModel(photos: photos, delegate: self))
		
		add(childVC: horizontalGalleryVC, to: horizontalGallery)

		horizontalGallery.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.bottom.equalTo(view.snp.bottom).inset(34)
			make.height.equalTo(66)
		}
	}
}


//MARK: - Activity screen
extension PhotoVC {

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


//MARK: - Pinch to Zoom
extension PhotoVC {

	private func addPinchToZoom() {
		imageView.addGestureRecognizer(pinch)
		pinch.addTarget(self, action: #selector(didPinch))
	}


	@objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
		guard let gestureView = pinch.view else { return }

		gestureView.transform = gestureView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
		pinch.scale = 1
	}
}


//MARK: - HorizontalGalleryDelegate
extension PhotoVC: HorizontalGalleryDelegate {
	func presentPhotoOnScreen(_ photo: UIImage) {
		imageView.image = photo
	}
}
