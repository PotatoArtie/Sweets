//
//  InfomationCell.swift
//  Assignment
//
//  Created by Atlas on 2022/08/21.
//

import UIKit
import Kingfisher

class InformationCell: UITableViewCell {
    
    @IBOutlet weak var profileImagView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var updateScoreButton: UIButton!
    @IBOutlet weak var levelLabel: InsetLabel!
    
    var updateScoreHandler: (() ->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateScoreButton.layer.cornerRadius = 20
        updateScoreButton.backgroundColor = .opggSoftBlue
        profileImagView.layer.cornerRadius = profileImagView.frame.width/2
        profileImagView.backgroundColor = .opggPaleGreyTwo
        levelLabel.textColor = .opggWhite
        levelLabel.backgroundColor = .opggDarkGrey90
        userNameLabel.font = .boldSystemFont(ofSize: 24)
        
    }
    
    func configure(summoner: Summoner?){
        guard let summoner = summoner else {
            return
        }

        self.userNameLabel.text = summoner.name
        self.profileImagView.kf.setImage(with: URL(string: summoner.profileImageURL))
        self.levelLabel.text = "\(summoner.level)"
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func updateScorePressed(_ sender: Any) {
        self.updateScoreHandler?()
    }
}
