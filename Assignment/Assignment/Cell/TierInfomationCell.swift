//
//  TierInfomationCell.swift
//  Assignment
//
//  Created by Atlas on 2022/08/22.
//

import UIKit
import Kingfisher

class TierInfomationCell: UICollectionViewCell {

    @IBOutlet weak var rankTypeLabel: UILabel!
    @IBOutlet weak var rankImageView: UIImageView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lpLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tierLabel.font = .boldSystemFont(ofSize: 18)
        self.detailButton.layer.cornerRadius = detailButton.frame.width/2
        self.detailButton.backgroundColor = .opggPaleGrey
        self.rankTypeLabel.textColor = .opggSoftBlue
        self.layer.borderWidth = 1
        self.layer.borderColor  = UIColor.opggPaleGreyTwo.cgColor
        self.layer.cornerRadius = 4
        self.outcomeLabel.textColor = .opggSteelGrey
    }
    
    func configure(league: League?) {
        guard let league = league else {
            return
        }

        self.rankImageView.kf.setImage(with: URL(string: league.tierRank.imageURL))
        self.rankTypeLabel.text = league.tierRank.name
        self.lpLabel.text = "\(league.tierRank.lp.convertCurrency()) LP"
        self.outcomeLabel.text = "\(league.wins)승 \(league.losses)패 (\(getWinRate(wins: league.wins, losses: league.losses))%)"
        
        tierLabel.text = league.tierRank.tier
        
    }
    
    func getWinRate(wins: Int, losses: Int) -> Int {
        if wins != 0 && losses != 0 {
            return Int(((Double(wins) / Double(wins + losses)) * 100).rounded())
        }else{
            return 0
        }
    }

}
