//
//  WatchVC.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/17.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit
import SnapKit

class WatchVC: UIViewController {

    var result: UILabel!
    var timer: Timer?
    var lableNum: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result = UILabel()
        result.textColor = .black
        result.textAlignment = .center
        result.text = "0"
        result.font = UIFont.systemFont(ofSize: 25)
        result.backgroundColor = .brown
        view.addSubview(result)
        result.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(400)
        }
    
        let startBtn: UIButton = UIButton()
        startBtn.setTitle("开始", for: .normal)
        startBtn.backgroundColor = UIColor(red: 1, green: 101/255.0, blue: 27/255.0, alpha: 1)
        startBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        view.addSubview(startBtn)
        
        startBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(result.snp.bottom)
            make.width.equalTo(view.frame.width / 2)
        }

        let endBtn: UIButton = UIButton()
        endBtn.setTitle("停止", for: .normal)
        endBtn.backgroundColor = UIColor(red: 98/255.0, green: 242/255.0, blue: 23/255.0, alpha: 1)
        endBtn.addTarget(self, action: #selector(end), for: .touchUpInside)
        view.addSubview(endBtn)
        
        endBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.top.equalTo(result.snp.bottom)
            make.width.equalTo(view.frame.width / 2)
        }

        let resetButton = UIButton()
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalTo(-10)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        
    }
    
    @objc func start() {
        if timer != nil {
            end()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.lableNum += 0.1
            self.result.text = String(format: "%.1f", self.lableNum)
        })
        timer?.fire()
    }
    
    @objc func end() {
        timer?.invalidate()
    }
    
    @objc func reset() {
        lableNum = 0
        result.text = "0"
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
}
