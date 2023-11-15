//
//  CollectionViewContainer.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation
import UIKit

class CollectionViewContainer : NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var config: CollectionViewConfig
    var collectionView: UICollectionView
    
    init(_ config: CollectionViewConfig, _ collectionView: UICollectionView) {
        self.config = config
        self.collectionView = collectionView
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return config.options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.recommendationCollectionViewCellIdentifier.rawValue, for: indexPath) as! CollectionViewCell
        cell.configure(config.options[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.config.function(config.options[indexPath.row].link)
    }
    
    func setOptions(_ options: [CollectionViewCellConfig]) {
        self.config.options = options
        self.collectionView.reloadData()
    }
    
    func setFlowlayout(_ flowLayout: UICollectionViewFlowLayout) {
        self.collectionView.collectionViewLayout = flowLayout
    }
}
