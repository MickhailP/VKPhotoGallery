//
//  GalleryVC.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import Foundation
import UIKit
import SnapKit


final class GalleryVC: UIViewController {

	let viewModel: GalleryVCViewModel

	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!

	enum Section {
		case main
	}


	init(coordinator: Coordinator, user: User, networkingManager: NetworkingManager) {
		self.viewModel = GalleryVCViewModel(coordinator: coordinator, user: user, networkingManager: networkingManager)
		super.init(nibName: nil, bundle: nil)
		self.title = "MobileUP Gallery"
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		configureNavController()
		configureCollectionView()
		requestPhotos()
		configureDataSource()

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

	private func configureCollectionView() {
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
		viewModel.requestImages(ofOwner: VKAppID.albumOwner, fromAlbum: VKAppID.albumId) { [weak self] photos in
			self?.updateData(with: photos)
		}
	}
}


//MARK: - DataSource configuration
extension GalleryVC {

	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Photo> (collectionView: collectionView, cellProvider: { collectionView, indexPath, photo in

			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellsNames.photoCell, for: indexPath) as! PhotoCell

			cell.set(photo: photo)
			return cell
		})
	}

	private func updateData(with photo: [Photo]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Photo> ()
		snapshot.appendSections([.main])
		snapshot.appendItems(viewModel.photos)

		DispatchQueue.main.async {
			self.dataSource.apply(snapshot)
		}
	}
}

//MARK: - UICollectionViewDelegate
extension GalleryVC: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let photo = viewModel.photos[indexPath.item]
		viewModel.coordinator?.presentPhotoScreen(for: photo)
	}
}
