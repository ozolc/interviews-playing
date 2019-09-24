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
    
    var apiService: APIServiceProtocol!
    
    convenience init(apiService: APIServiceProtocol) {
        self.init()
        self.apiService = apiService
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .white
        setupTableView()
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddEntry))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleGetEntries))
        
        self.title = "Айпартнер | бинет"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @objc func handleAddEntry() {
        let controller = AddEntryViewController()
        controller.navigationItem.title = "Добавить новую запись"
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleGetEntries() {
        tableView.reloadData()
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .white
        tableView.register(MainViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
//        return entries?.data.first?.count ?? 0
        return entries?.data.first?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainViewCell
        
        cell.selectionStyle = .none
        
        if let entry = entries?.data.first?[indexPath.row] {
            cell.entry = entry
        }
        return cell
    }
    
}

//extension MainViewController: AddEntryViewControllerDelegate {
//    func didAddedEntry(entries: [[EntryResponseData]]) {
//        localEntries = entries
//    }
//}
