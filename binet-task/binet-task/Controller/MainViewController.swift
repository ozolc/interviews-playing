//
//  MainViewController.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let cellId = "cellId"
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .yellow
        setupTableView()
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        print(Constants.tokenId)
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .yellow
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries?.data.first?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let entries = entries?.data.first {
            let entry = entries[indexPath.row]
            cell.textLabel?.text = entry.body
        }
        return cell
    }
    
}
