//
//  LimitInputTextField.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/17.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit
import SnapKit

class LimitInputTextField: UIViewController, UITextViewDelegate {

    var limitedTextView: UITextView!
var allowInputNumberlabel: UILabel!
    let maxTextSize = 140

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        limitedTextView = UITextView()
        limitedTextView.font = UIFont.systemFont(ofSize: 30)
        limitedTextView.delegate = self
        view.addSubview(limitedTextView)

        limitedTextView.snp.makeConstraints { (make) in
        make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        make.left.right.equalToSuperview()
        make.height.equalTo(400)
        }
        
        allowInputNumberlabel = UILabel()
        allowInputNumberlabel.text = "140"
        allowInputNumberlabel.textAlignment = .right
        view.addSubview(allowInputNumberlabel)
        
        allowInputNumberlabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(limitedTextView.snp.bottom)
            make.right.equalTo(limitedTextView.snp.right).offset(-10)
            make.width.height.equalTo(50)
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.isEmpty { return true}
        
        let selectedRange = textView.markedTextRange
            if let selectedRange = selectedRange {
                let position =  textView.position(from: (selectedRange.start), offset: 0)
                if position != nil {
                    let startOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
                    let endOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange.end)
                    let offsetRange = NSRange(location: startOffset, length: endOffset - startOffset) // 高亮部分起始位置
                    if offsetRange.location < maxTextSize {
                        // 高亮部分先不进行字数统计
                        return true
                    } else {
                        //字数已达上限
                        return false
                    }
                }
            }
        // 在最末添加
        if range.location >= maxTextSize {
            //字数已达上限
            return false
        }

            // 在其他位置添加
        guard textView.text.count >= maxTextSize  && range.length <  text.count else {
            return false

        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count > maxTextSize {
                let selectRange = textView.markedTextRange
                if let selectRange = selectRange {
                    let position =  textView.position(from: (selectRange.start), offset: 0)
                    guard position != nil else {
                        // 高亮部分不进行截取，否则中文输入会把高亮区域的拼音强制截取为字母，等高亮取消后再计算字符总数并截取
                        return
                    }
                }
                textView.text = String(textView.text.prefix(140))

                // 对于粘贴文字的case，粘贴结束后若超出字数限制，则让光标移动到末尾处
                textView.selectedRange = NSRange(location: textView.text.count, length: 0)
        }
        allowInputNumberlabel.text = "\(maxTextSize - textView.text.count)"
        
    }

}
