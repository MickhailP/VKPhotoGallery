//
//  HorizontalGalleryVC.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import UIKit

final class HorizontalGalleryVC: CollectionVC {

	var viewModel: HorizontalGalleryViewModel


	init(viewModel: HorizontalGalleryViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


    override func viewDidLoad() {
        super.viewDidLoad()
		self.update(dataSource: self.viewModel.photos, with: self.viewModel.photos)
    }


	override func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createOneColumnHorizontalFlowLayout(in: view))
		collectionView.delegate = self

		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: CellsNames.photoCell)
		collectionView.snp.makeConstraints { make in
			make.top.bottom.leading.trailing.equalToSuperview()
		}
	}
}


//MARK: - UICollectionViewDelegate
extension HorizontalGalleryVC: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell
		guard let photoImage = cell?.photoImageView.image else { return }
		viewModel.show(photoImage)
	}
}

