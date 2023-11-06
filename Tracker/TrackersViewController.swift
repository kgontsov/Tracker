//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Kirill Gontsov on 06.11.2023.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    private let trackersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    private let emptyView = EmptyView(
        title: "Что будем отслеживать?"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
}
