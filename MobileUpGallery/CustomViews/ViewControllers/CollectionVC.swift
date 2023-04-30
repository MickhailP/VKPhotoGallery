//
//  CollectionVC.swift
//  MobileUpGallery
//
//  Created by Миша Перевозчиков on 29.04.2023.
//

import UIKit

class CollectionVC: UIViewController {

	enum Section {
		case main
	}


	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!


    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground

		configureCollectionView()
		configureDataSource()
    }


	func configureCollectionView() {

	}
}


//MARK: - DataSource configuration
extension CollectionVC {

	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Photo> (collectionView: collectionView, cellProvider: { collectionView, indexPath, photo in

			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellsNames.photoCell, for: indexPath) as! PhotoCell

			cell.set(photo: photo)
			return cell
		})
	}


	func update(dataSource: [Photo], with newData: [Photo]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Photo> ()
		snapshot.appendSections([.main])
		snapshot.appendItems(newData)

		DispatchQueue.main.async {
			self.dataSource.apply(snapshot)
		}
	}
}
