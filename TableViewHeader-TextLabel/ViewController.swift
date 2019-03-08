//
//  ViewController.swift
//  TableViewHeader-TextLabel
//
//  Created by Murray Sagal on 2019-03-07.
//  Copyright © 2019 Murray Sagal. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let model = "abcde".map {return String($0)}
    let headerTitles = ["a is for apple" + "\n" + "a multiline apple", "b", "c is for can you please fix this", "d is for dumb", "e is for eagerly awaiting a fix"]
    let defaultHeaderTitle = "header"
    lazy var headerTitle = defaultHeaderTitle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TableView Header"
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(reset), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
    }

    // MARK: - Table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Tap any row to change the header. Pull down for the default header. Tap the button for reloadData()."
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = model[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        updateHeader(with: headerTitles[indexPath.row])
    }

    func updateHeader(with title: String) {
        guard let headerView = tableView.headerView(forSection: 0), let label = headerView.textLabel else {return}
        headerTitle = title
        label.text = headerTitle
//        label.sizeToFit()
//        label.numberOfLines = 1
    }

    @objc func reset() {
        updateHeader(with: defaultHeaderTitle)
        refreshControl?.endRefreshing()
    }

    @objc func reload() {
        tableView.reloadData()
    }
}

