//
//  UserScoreViewController+Extension.swift
//  Assignment
//
//  Created by Dongju on 2022/08/19.
//

import UIKit

extension UserScoreViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension UserScoreViewController: UITableViewDelegate {}
