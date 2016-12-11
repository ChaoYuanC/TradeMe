//
//  TMPosterTableViewCell.swift
//  TradeMe
//
//  Created by Chao Yuan on 11/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit

class TMPosterHeaderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var postersCollectionView: UICollectionView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var listedDateLabel: UILabel?
    @IBOutlet var priceLabel: UILabel?
    @IBOutlet var heightView: UIView?
    
    fileprivate var postersUrls: [String]?
    fileprivate var title: String?
    fileprivate var listedDate: String?
    fileprivate var price: String?
    
    private let posterCellIdentifier = "TMPosterCollectionViewCell"
    private lazy var posterCell: TMPosterCollectionViewCell = {
        return Bundle.main.loadNibNamed(self.posterCellIdentifier, owner: nil, options: nil)![0] as! TMPosterCollectionViewCell
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.postersCollectionView?.registerNibForCellReuseIdentifier(self.posterCellIdentifier)
        
    }
    
    func setupWith(object: TMPosterObject) {
        self.postersUrls = object.posters
        self.title = object.title
        self.listedDate = object.listedDate
        self.price = object.priceString
        
        
        self.titleLabel?.text = object.title
        self.listedDateLabel?.text = object.listedDate
        self.priceLabel?.text = object.priceString
        self.postersCollectionView?.reloadData()
    }
    
    func headerHeight() -> CGFloat {
        self.layoutIfNeeded()
        return self.heightView?.bounds.size.height ?? 0
    }
    
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postersUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.posterCellIdentifier, for: indexPath) as! TMPosterCollectionViewCell
        if let url = self.postersUrls?[indexPath.row] {
            cell.setupWith(posterUrl: url)
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
