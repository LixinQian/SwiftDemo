//
//  PullToRefresh.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/17.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class PullToRefresh: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataSource = [Date]()
    let refresh = UIRefreshControl()
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        addNewDataToArray()

        refresh.attributedTitle = NSAttributedString(string: "还拉啊，快断啦")
        refresh.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        tableView.addSubview(refresh)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DateCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "DateCell")
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH时mm分ss秒"
        let dateStr = dateFormatter.string(from: dataSource[indexPath.row])
        cell?.textLabel?.text = dateStr
        return cell!
    }

    func addNewDataToArray() {
        dataSource.insert(Date(), at: 0)
    }

    @objc func pullRefresh() {
        addNewDataToArray()
        refresh.endRefreshing()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
}
