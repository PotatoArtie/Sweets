//
//  TierCell.swift
//  Assignment
//
//  Created by Atlas on 2022/08/22.
//

import UIKit

class TierCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.backgroundColor = .opggPaleGrey
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension TierCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        self.collectionView.delegate = dataSourceDelegate
        self.collectionView.dataSource = dataSourceDelegate
        
    }
    
}
