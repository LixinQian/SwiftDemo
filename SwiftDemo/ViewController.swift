//
//  ViewController.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/17.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let arr = ["ShowFont", "WatchVC", "FindMyPosition", "LimitInputTextField", "PullToRefresh", "PlayLocalVideo", "SimplePhotoBrowser", "ColorGradient", "SwipeableCell", "StretchyHeader", "GradientInTableView", "EmojiSlotMachine", "AnimationInTableViewCell", "VideoSplash", "TumblrMenu", "LoginAnimation", "ThreeDTouchQuickAction", "SpotlightSearch"]
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = arr[indexPath.row]
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let instanll = NSClassFromString(nameSpace + "." + name)! as! UIViewController.Type
        let VC = instanll.init()
        navigationController?.pushViewController(VC, animated: true)
    }

}
