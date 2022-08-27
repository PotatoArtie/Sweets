//
//  UserScoreViewController.swift
//  Assignment
//
//  Created by Dongju on 2022/08/19.
//

import UIKit
import RxSwift

class UserScoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var footerview: UIView!

    var viewModel = ScoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setup()
        self.setupRX()
        
        viewModel.action.summoner.accept("genetory")
        
    }
}

extension UserScoreViewController {
    func setup(){
        let informationNib = UINib(nibName: "InformationCell", bundle: nil)
        tableView.register(informationNib, forCellReuseIdentifier: "informationCell")
        
        let gameAnalysisNib = UINib(nibName: "RecentGameAnalysisCell", bundle: nil)
        tableView.register(gameAnalysisNib, forCellReuseIdentifier: "recentGameAnalysisCell")
        
        let gameInformationNib = UINib(nibName: "GameInformationCell", bundle: nil)
        tableView.register(gameInformationNib, forCellReuseIdentifier: "gameInformationCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
    }
    
    func setupRX(){
        viewModel.state.gameInformation
            .bind(onNext: reload)
            .disposed(by: self.disposeBag)
        
        viewModel.state.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }

                if isLoading {
                    self.indicator.startAnimating()
                    self.footerview.isHidden = false
                }else {
                    self.indicator.stopAnimating()
                    self.footerview.isHidden = true
                    self.tableView.isScrollEnabled = true
                    self.tableView.layoutIfNeeded()
                }
            }).disposed(by: self.disposeBag)
    }

    private func reload(){
        
        self.tableView.reloadData()
    }
}



