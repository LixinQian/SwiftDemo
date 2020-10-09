//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/22.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    init(with model: [String: Any]) {
        super.init(nibName: nil, bundle: nil)
        let cover = model["cover"] as? UIImage
        let desc = model["description"] as? String
        let name = model["name"] as? String
        _ = model["rank"] as? Int
        
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0.0
        let stateHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let coverImageView = UIImageView(frame: CGRect(x: 10, y: navigationBarHeight + stateHeight + 80, width: 100, height: 140))
        view.addSubview(coverImageView)
        coverImageView.center.x = view.center.x
        coverImageView.image = cover
        
        let nameLabel = UILabel(frame: CGRect(x: 10, y: navigationBarHeight + stateHeight + coverImageView.frame.height + 60 + 10, width: 300, height: 50))
        nameLabel.text = name
        nameLabel.textAlignment = .center
        nameLabel.center.x = view.center.x
        view.addSubview(nameLabel)
        
        let textViewY = navigationBarHeight + stateHeight + coverImageView.frame.height + 50 + 50 + 10
        let textView = UITextView(frame: CGRect(x: 0, y: textViewY, width: view.frame.width, height: view.frame.height - textViewY - 10))
        view.addSubview(textView)
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.text = desc
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = false
    }
}
