//
//  GameInformationCell.swift
//  Assignment
//
//  Created by Atlas on 2022/08/22.
//

import UIKit
import Kingfisher

class GameInformationCell: UITableViewCell {

    @IBOutlet weak var gameResultLabel: UILabel!
    @IBOutlet weak var gameChampionImageView: UIImageView!
    @IBOutlet weak var gameTypeLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var killDeathLabel: UILabel!
    @IBOutlet weak var largestMultiKillLabel: InsetLabel!
    @IBOutlet weak var contributionForKillRateLabel: UILabel!
    @IBOutlet weak var gameResultContainerView: UIView!
    @IBOutlet weak var opScroeBadgeLabel: InsetLabel!
    @IBOutlet weak var gameLengthLabel: UILabel!
    
    @IBOutlet var peakImageview: [UIImageView]!
    @IBOutlet var spellsImageView: [UIImageView]!
    @IBOutlet var itemsImageView: [UIImageView]!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameChampionImageView.image = UIImage(named: "iconLolAll")
        self.itemsImageView.forEach { imageView in
            imageView.image = nil
        }
        
        self.spellsImageView.forEach { imageView in
            imageView.image = nil
        }
        
        self.peakImageview.forEach { imageView in
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gameChampionImageView.layer.cornerRadius = gameChampionImageView.frame.height/2
        self.opScroeBadgeLabel.layer.borderColor = UIColor.white.cgColor
        self.opScroeBadgeLabel.textColor = .opggWhite
        self.largestMultiKillLabel.layer.borderColor = UIColor.opggDarkishPink.cgColor
        self.opScroeBadgeLabel.layer.cornerRadius = 8
        self.largestMultiKillLabel.layer.cornerRadius = 10
        self.gameResultLabel.textColor = .opggWhite
        self.gameLengthLabel.textColor = .opggWhite
        
        self.itemsImageView.forEach { imageView in
            imageView.layer.cornerRadius = imageView.tag == 7 ? imageView.frame.height/2 : 4
        }
        
        self.spellsImageView.forEach { imageView in
            imageView.layer.cornerRadius = 4
        }
        
        self.peakImageview.forEach { imageView in
            imageView.layer.cornerRadius = imageView.frame.height/2
        }

        self.layer.addBorder([.bottom , .top], color: .opggPaleGreyTwo, width: 2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(game: Game?){
        guard let game = game else {
            return
        }        
        self.gameChampionImageView.kf.setImage(with: URL(string: game.champion.imageURL))
        
        self.gameResultLabel.text = game.isWin ? "승":"패"
        self.gameResultContainerView.backgroundColor = game.isWin ? .opggSoftBlue : .opggDarkishPink
        self.gameTypeLabel.text = game.gameType
        self.createDateLabel.text = game.createDate.prevPlaytime()
        self.largestMultiKillLabel.text = game.stats.general.largestMultiKillString
         
        let killDeathString  = "\(game.stats.general.kill) / \(game.stats.general.death) / \(game.stats.general.assist)"
        
        self.killDeathLabel.attributedText = killDeathString.convertString(text: " \(game.stats.general.death) ")
            .changeTextFont(font: .boldSystemFont(ofSize: 16), text: killDeathString)
        
        self.contributionForKillRateLabel.text = "킬관여 \(game.stats.general.contributionForKillRate)"
        
        self.opScroeBadgeLabel.isHidden = game.stats.general.opScoreBadge.isEmpty
        self.opScroeBadgeLabel.text = !self.opScroeBadgeLabel.isHidden ? game.stats.general.opScoreBadge : ""
        
        self.opScroeBadgeLabel.backgroundColor = ScoreBadgeType.getBadgeColor(game.stats.general.opScoreBadge)
         
        self.gameLengthLabel.text = game.gameLength.toMMFormat()
        self.largestMultiKillLabel.isHidden = game.stats.general.largestMultiKillString.isEmpty
        self.largestMultiKillLabel.text = game.stats.general.largestMultiKillString.localized

        for (index, item) in game.spells.enumerated() {
            self.spellsImageView[index].kf.setImage(with: URL(string: item.imageURL))
        }

        for (index, item) in game.items.enumerated() {
            if index == game.items.count-1 { break }
            self.itemsImageView[index].kf.setImage(with: URL(string: item.imageURL))
        }
        
        self.itemsImageView[itemsImageView.count-1].kf.setImage(with: URL(string: game.items[game.items.count-1].imageURL))

        for (index, item) in game.peak.enumerated() {
            self.peakImageview[index].kf.setImage(with: URL(string: item))
        }
        
        
    }
    
}
