//
//  StretchyHeader.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/21.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class StretchyHeader: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var tableView: UITableView!
    var bannerImageView: UIImageView!
    private var dataSoruce: [String]!
    private let cellHeight: CGFloat = 66
    private let colorRatio: CGFloat = 10
    private let lyric = "when i was young i'd listen to the radio,waiting for my favorite songs,when they played i'd sing along,it make me smile,those were such happy times and not so long ago,how i wondered where they'd gone,but they're back again just like a long lost friend,all the songs i love so well,every shalala every wo'wo,still shines,every shing-a-ling-a-ling"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0.0
//        let stateHeight = UIApplication.shared.statusBarFrame.height
        let stateHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        bannerImageView = UIImageView(image: UIImage(named: "banner"))
        bannerImageView.frame = CGRect(x: 0, y: stateHeight + navigationBarHeight, width: view.bounds.width, height: view.bounds.width)
        view.addSubview(bannerImageView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: view.bounds.width + 10, width: view.bounds.width, height: view.bounds.height - view.bounds.width - 10), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        dataSoruce = lyric.split(separator: ",").map(String.init)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            cell.frame.origin.y = tableHeight
            UIView.animate(withDuration: 1.0, delay: 0.04 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: []) {
                cell.frame.origin.y = 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSoruce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "StretchyHeaderCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "StretchyHeaderCell")
        }
        cell?.textLabel?.text = dataSoruce[indexPath.row]
        cell?.textLabel?.textColor = .black
        cell?.frame.origin.y = cellHeight
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let maxOffsetY = tableView.frame.height
        let validateOffsetY =  offsetY / maxOffsetY
        let scaleFactor = 1 - validateOffsetY
        bannerImageView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
    }
}
