//
//  AnimationInTableViewCell.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/21.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class AnimationInTableViewCell: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellHeight: CGFloat = 66
    private let colorRatio: CGFloat = 10
    var table: UITableView!
    private let lyric = "when i was young i'd listen to the radio,waiting for my favorite songs,when they played i'd sing along,it make me smile,those were such happy times and not so long ago,how i wondered where they'd gone,but they're back again just like a long lost friend,all the songs i love so well,every shalala every wo'wo,still shines,every shing-a-ling-a-ling"
    private var dataSource: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        table = UITableView(frame: view.frame)
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        
        dataSource = lyric.split(separator: ",").map(String.init)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
        let cells = table.visibleCells
        let tableHeight: CGFloat = table.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            cell.frame.origin.y = tableHeight
            UIView.animate(withDuration: 1.0, delay: 0.04 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: []) {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "animationInTableViewCell")
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = .white
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: cellHeight))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bgView.frame
        let lowerColor: CGColor = UIColor(red: 1.0, green: (CGFloat(indexPath.row * 2) * colorRatio)/255.0, blue: (CGFloat(indexPath.row * 2) * colorRatio)/255.0, alpha: 1).cgColor
        let upperColor: CGColor = UIColor(red: 1.0, green: (CGFloat(indexPath.row * 2) * colorRatio + colorRatio)/255.0, blue: (CGFloat(indexPath.row * 2) * colorRatio + colorRatio)/255.0, alpha: 1).cgColor

        gradientLayer.colors = [lowerColor, upperColor]
        bgView.layer.addSublayer(gradientLayer)
        cell.addSubview(bgView)
        cell.sendSubviewToBack(bgView)
        cell.frame.origin.y = cellHeight
        return cell
    }
}
