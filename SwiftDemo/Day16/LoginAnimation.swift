//
//  LoginAnimation.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/21.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class LoginAnimation: UIViewController {

    let buttonHeight: CGFloat = 56
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(red: 25/255.0, green: 153/255.0, blue: 3/255.0, alpha: 1)
        
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 334, height: 101))
        logoImageView.image = UIImage(named: "logo")
        view.addSubview(logoImageView)
        logoImageView.center.x = view.center.x
        
        let loginButton = UIButton(frame: CGRect(x: 0, y: (view.frame.size.height - buttonHeight), width: view.frame.width / 2.0, height: buttonHeight))
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitle("LOG IN", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.backgroundColor = UIColor(red: 35/255.0, green: 36/255.0, blue: 38/255.0, alpha: 1)
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        let signupButton = UIButton(frame: CGRect(x: view.frame.width / 2.0, y: (view.frame.size.height - buttonHeight), width: view.frame.width / 2.0, height: buttonHeight))
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.setTitle("SIGN UP", for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signupButton.backgroundColor = UIColor(red: 42/255.0, green: 183/255.0, blue: 90/255.0, alpha: 1)
        view.addSubview(signupButton)
    }
    @objc func loginAction() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: false)
    }

}
