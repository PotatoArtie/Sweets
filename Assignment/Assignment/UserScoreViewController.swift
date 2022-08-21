//
//  UserScoreViewController.swift
//  Assignment
//
//  Created by Dongju on 2022/08/19.
//

import UIKit

class UserScoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension UserScoreViewController {
    func setup(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
