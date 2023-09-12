//
//  TableViewController.swift
//  TableView
//
//  Created by Александр Горелкин on 10.09.2023.
//

import UIKit

final class TableViewController: UIViewController {
    
    
    private lazy var dataArray: [Int] = Array(0...30)
    private lazy var wasPicked = [Int]()
    private lazy var dataSource: UITableViewDiffableDataSource<String, Int> = {
        UITableViewDiffableDataSource<String, Int>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
            cell.configure(textLabel: "\(itemIdentifier)")
            cell.tag = itemIdentifier
            return cell
        }
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 8
        table.delegate = self
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return table
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .done, target: self, action: #selector(shuffle))
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
        updateArray(dataArray)
    }
    
    private func updateArray(_ array: [Int]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, Int>()
        snapshot.appendSections(["first"])
        snapshot.appendItems(array, toSection: "first")
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc private func shuffle() {
        updateArray(dataArray.shuffled())
    }
    
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        if wasPicked.contains(item) {
            wasPicked = wasPicked.filter { $0 != item }
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            return
        } else {
            wasPicked.append(item)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        guard let first = dataSource.snapshot().itemIdentifiers.first,
              first != item else { return }
        var snapshot = dataSource.snapshot()
        snapshot.moveItem(item, beforeItem: first)
        dataSource.apply(snapshot)
    }
    
}
