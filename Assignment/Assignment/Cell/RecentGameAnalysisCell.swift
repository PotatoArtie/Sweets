//
//  RecentGameAnalysisCell.swift
//  Assignment
//
//  Created by Atlas on 2022/08/21.
//

import UIKit
import Kingfisher
import SwiftUI

class RecentGameAnalysisCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var winScoreLabel: UILabel!
    @IBOutlet weak var killRateLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    @IBOutlet weak var mostWinRateTitleLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var positionImageView: UIImageView!
    @IBOutlet var mostWinRateChampsImageView: [UIImageView]!
    @IBOutlet var mostWinRateLabel: [UILabel]!
    @IBOutlet weak var postionWinRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.textColor = .oppggCoolGrey
        self.winScoreLabel.textColor = .oppggCoolGrey
        self.mostWinRateTitleLabel.textColor = .oppggCoolGrey
        self.positionLabel.textColor = .oppggCoolGrey
        
        mostWinRateChampsImageView.forEach { imageView in
            imageView.layer.cornerRadius = imageView.frame.height / 2
            imageView.tintColor = .opggPaleGrey
        }
        
        layer.addBorder([.bottom], color: .opggPaleGreyTwo, width: 2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(game: GameInformationResponse?) {
        guard let game = game else {
            return
        }
        
        let summary = game.summary
        let winRate = game.getWinRate(wins: summary.wins, losses: summary.losses)
        let killRateString = "\(game.getAverageRecent20GamesKills()) / \(game.getAverageRecent20GamesDeaths()) / \(game.getAverageRecent20GamesAssists())"
        self.killRateLabel.attributedText = killRateString.convertString(text: " \(game.getAverageRecent20GamesDeaths()) ")
            .changeTextFont(font: .boldSystemFont(ofSize: 14), text: killRateString)
        self.winRateLabel.attributedText = "\(game.getKDA()):1 (\(winRate)%)"
            .convertString(text: "(\(winRate)%)")
            .changeTextColor(color: .opggGreenBlue, text: "\(game.getKDA()):1")
        self.winScoreLabel.text = "\(summary.wins)승 \(summary.losses)패"
        self.titleLabel.text = "최근 \(summary.getRecentAnalyzedGameCount())게임 분석"

        for (index,item) in game.sortByHighWinRate().enumerated() {
            self.mostWinRateChampsImageView[index].setImage(url: item.imageURL)
            self.mostWinRateLabel[index].text = "\(game.getWinRate(wins: item.wins, losses: item.losses))%"
        }

        if let position = game.sortByHighWinRatePostion() {
            self.postionWinRateLabel.text = "\(game.getWinRate(wins: position.wins, losses: position.losses))%"
            
            self.positionImageView.image = UIImage(named: PositionType.getImageURLByPosition(positionName: position.positionName))
        }else{
            
        }
    }
}
