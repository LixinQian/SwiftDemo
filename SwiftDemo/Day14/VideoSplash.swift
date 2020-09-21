//
//  VideoSplash.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/21.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class VideoSplash: VideoSplashViewController {
    let buttonHeight: CGFloat = 56
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
        
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 135, width: 334, height: 101))
        logoImageView.image = UIImage(named: "logo")
        view.addSubview(logoImageView)
        logoImageView.center.x = view.center.x
        
        let loginButton = UIButton(frame: CGRect(x: 0, y: (view.frame.size.height - buttonHeight), width: view.frame.width / 2.0, height: buttonHeight))
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitle("LOG IN", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.backgroundColor = UIColor(red: 35/255.0, green: 36/255.0, blue: 38/255.0, alpha: 1)
        view.addSubview(loginButton)
        
        let signupButton = UIButton(frame: CGRect(x: view.frame.width / 2.0, y: (view.frame.size.height - buttonHeight), width: view.frame.width / 2.0, height: buttonHeight))
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.setTitle("SIGN UP", for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signupButton.backgroundColor = UIColor(red: 42/255.0, green: 183/255.0, blue: 90/255.0, alpha: 1)
        view.addSubview(signupButton)
    }
    
    func setupVideoBackground() {
        
        let url = NSURL.fileURL(withPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url as NSURL
        view.isUserInteractionEnabled = false
        
    }
}
