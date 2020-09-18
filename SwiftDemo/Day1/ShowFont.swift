//
//  ShowFont.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/17.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class ShowFont: UIViewController {
    var arr = [String]()
    let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        label.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 200)
        label.text = "我们都是孩子啊，渴望长大，HelloWorld"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(label)

        let btn = UIButton(frame: CGRect(x: 100, y: 400, width: 150, height: 70))
        btn.setTitle("改变字体", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(changeFontFamily), for: .touchUpInside)
        view.addSubview(btn)
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        
        printAllSupportedFontNames()
    }

    @objc func changeFontFamily() {
        let index = Int.random(in: 0...arr.count)
        label.font = UIFont(name: arr[index], size: 20)
    }
    
    func printAllSupportedFontNames() {
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
//            print("----------\(familyName)")
            let names = UIFont.fontNames(forFamilyName: familyName)
            for fontName in names {
//                print("+++++++++\(fontName)")
                arr.append(fontName)
            }
        }
    }
}
