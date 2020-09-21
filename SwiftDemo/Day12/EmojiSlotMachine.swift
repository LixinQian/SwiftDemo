//
//  EmojiSlotMachine.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/21.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class EmojiSlotMachine: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var slotMachine: UIPickerView!
    var emojiArray = ["😀", "😎", "😈", "👻", "🙈", "🐶", "🌚", "🍎", "🎾", "🐥", "🐔"]
    var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSlotMachine()
    }
    
    func createSlotMachine() {
        slotMachine = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 220))
        view.addSubview(slotMachine)
        slotMachine.dataSource = self
        slotMachine.delegate = self
        slotMachine.center.x = view.center.x
        slotMachine.center.y = view.center.y - 50
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 0, animated: false)
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 1, animated: false)
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 2, animated: false)
        
        let goButton = UIButton(type: .roundedRect)
        goButton.backgroundColor = .green
        goButton.frame = CGRect(x: 0, y: 0, width: 275, height: 40)
        view.addSubview(goButton)
        
        goButton.setTitle("Go", for: .normal)
        goButton.setTitleColor(UIColor.white, for: .normal)
        goButton.center.y = view.center.y + 140
        goButton.center.x = view.center.x
        goButton.addTarget(self, action: #selector(goAction), for: .touchUpInside)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(longTapAction))
        doubleTapGesture.numberOfTapsRequired = 2
        goButton.addGestureRecognizer(doubleTapGesture)
        
        resultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        resultLabel.text = ""
        resultLabel.textColor = UIColor.black
        resultLabel.center.x = view.center.x
        resultLabel.center.y = goButton.center.y + 100
        view.addSubview(resultLabel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 90
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = emojiArray[row]
        pickerLabel.textAlignment = .center
        pickerLabel.font = UIFont.systemFont(ofSize: 60)
        return pickerLabel
    }
    
    @objc func goAction() {
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 0, animated: true)
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 1, animated: true)
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 2, animated: true)
        
        judge()
    }
    
    @objc func longTapAction() {
        let result = Int(arc4random())%(emojiArray.count - 2)
        slotMachine.selectRow(result + 1, inComponent: 0, animated: true)
        slotMachine.selectRow(result + 1, inComponent: 1, animated: true)
        slotMachine.selectRow(result + 1, inComponent: 2, animated: true)
        
        judge()
    }
    
    func judge() {
        if slotMachine.selectedRow(inComponent: 0) == slotMachine.selectedRow(inComponent: 1) && slotMachine.selectedRow(inComponent: 1) == slotMachine.selectedRow(inComponent: 2) {
            resultLabel.text = "👏👏👏"
        } else {
            resultLabel.text = "💔💔💔"
        }
    }

}
