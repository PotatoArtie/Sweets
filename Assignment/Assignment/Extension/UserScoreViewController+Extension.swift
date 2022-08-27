//
//  UserScoreViewController+Extension.swift
//  Assignment
//
//  Created by Dongju on 2022/08/19.
//

import UIKit

extension UserScoreViewController: UITableViewDelegate {}
extension UserScoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let serviceCell = cell as? TierCell else { return }
            serviceCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 3 { return 1 }
        else { return viewModel.games.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell") as? InformationCell else { return UITableViewCell() }
            cell.configure(summoner: self.viewModel.summoner)
            cell.backgroundColor = .opggPaleGrey
            
            cell.updateScoreHandler = { [weak self] in
                guard let self = self else { return }
                self.viewModel.action.summoner.accept("genetory")
            }
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tierCell") as? TierCell else { return UITableViewCell() }
            cell.backgroundColor = .opggPaleGrey
            cell.collectionView.reloadData()
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "recentGameAnalysisCell") as? RecentGameAnalysisCell else { return UITableViewCell() }
            cell.configure(game: viewModel.gameInformation)
            cell.backgroundColor = .white
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameInformationCell") as? GameInformationCell else { return UITableViewCell() }
            if !viewModel.games.isEmpty{
                cell.configure(game: viewModel.games[indexPath.item])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return CGFloat(130)
        }
        return UITableView.automaticDimension
    }
    
}

extension UserScoreViewController: UICollectionViewDelegate {}
extension UserScoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tierInfomationCell", for: indexPath) as? TierInfomationCell else {
            return UICollectionViewCell()
        }
        cell.configure(league: viewModel.summoner?.leagues[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.summoner?.leagues.count ?? 0
    }
    
}

extension UserScoreViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            if !viewModel.isLoading {
                self.viewModel.state.isLoading.accept(true)
                scrollView.isScrollEnabled = false
                if !self.viewModel.games.isEmpty {
                    let lastGame = self.viewModel.games[self.viewModel.games.count-1]
                    
                    guard let name = self.viewModel.summoner?.name else {
                        return
                    }
                    let request = GameInformationRequest(name: name, lastMatch: Int64(lastGame.createDate))
                    viewModel.isLoading = true
                    viewModel.action.gameInformation.accept(request)
                }
            }
        }
    }
}
