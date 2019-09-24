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
        
        view.backgroundColor = .white
        setupTableView()
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        print(entries?.data.first?.count ?? "")
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .white
        tableView.register(MainViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Список записей"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entry = entries?.data.first?[indexPath.row] else { return }
        
        let controller = EntryViewController(entry: entry)
        controller.entry = entry
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries?.data.first?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainViewCell
        
        cell.selectionStyle = .none
        
        if let entries = entries?.data.first {
            let entry = entries[indexPath.row]
            cell.entry = entry
        }
        return cell
    }
    
}
