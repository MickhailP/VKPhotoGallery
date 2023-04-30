//
//  GalleryVC.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import Foundation
import UIKit
import SnapKit


final class GalleryVC: CollectionVC {

	let viewModel: GalleryVCViewModel


	init(coordinator: Coordinator, user: User, networkingManager: NetworkingManager) {
		self.viewModel = GalleryVCViewModel(coordinator: coordinator, user: user, networkingManager: networkingManager)
		super.init(nibName: nil, bundle: nil)
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavController()
		requestPhotos()
	}


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.title = "MobileUP Gallery"
	}

	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationItem.title = " "
	}


	@objc func exit(){
		viewModel.coordinator?.presentLoginView()
	}


	private func configureNavController() {
		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = false

		navigationItem.titleView?.sizeToFit()
		navigationItem.setHidesBackButton(true, animated:true)

		let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exit))
		exitButton.customView?.sizeToFit()
		self.navigationItem.rightBarButtonItem = exitButton
	}


	override func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
		collectionView.delegate = self
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: CellsNames.photoCell)
		collectionView.translatesAutoresizingMaskIntoConstraints = false


		collectionView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalToSuperview()
			make.trailing.leading.equalTo(view.safeAreaLayoutGuide)
		}
	}


	func requestPhotos() {
		viewModel.requestImages(ofOwner: VKAppID.albumOwner, fromAlbum: VKAppID.albumId) { [weak self] result in
			guard let self else { return }

			switch result {
				case.success(let photos):
					self.update(dataSource: self.viewModel.photos, with: photos)
				case .failure(let error):
					self.presentAlertOnMainTread(title: "Error", message: "The photos wasn't received. Error: \(error.rawValue)", buttonTitle: "Ok")
			}
		}
	}
}


//MARK: - UICollectionViewDelegate
extension GalleryVC: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let photo = viewModel.photos[indexPath.item]
		viewModel.coordinator?.presentPhotoScreen(for: photo, photos: viewModel.photos)
	}
}
