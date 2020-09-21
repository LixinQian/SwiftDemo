//
//  TumblrMenu.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/21.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class TumblrMenu: UIViewController {
    
    var blurView: UIVisualEffectView!
    var alphaBtn: UIButton!
    var quoteBtn: UIButton!
    var chatBtn: UIButton!
    var photoBtn: UIButton!
    var linkBtn: UIButton!
    var audioBtn: UIButton!
    let dumpingRate: CGFloat = 0.7
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView(frame: view.frame)
        bgImageView.image = UIImage(named: "launchImg")
        view.addSubview(bgImageView)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tapGes)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func tapAction() {
        self.setupFunctions()
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(removeBlur))
        blurView.addGestureRecognizer(tapGes)
        blurView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.blurView.alpha = 1
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: dumpingRate, initialSpringVelocity: 10, options: .allowAnimatedContent) {
            self.alphaBtn.frame.origin.x = 60
            self.photoBtn.frame.origin.x = 192
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: dumpingRate, initialSpringVelocity: 10, options: .allowAnimatedContent) {
            self.quoteBtn.frame.origin.x = 60
            self.linkBtn.frame.origin.x = 192
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: dumpingRate, initialSpringVelocity: 10, options: .allowAnimatedContent) {
            self.chatBtn.frame.origin.x = 60
            self.audioBtn.frame.origin.x = 192
        }
    }
    
    func setupFunctions() {
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        alphaBtn = UIButton(frame: CGRect(x: -88, y: 180, width: 88, height: 88))
        alphaBtn.setImageAndTitle(imageName: "Text", title: "Message", type: .positionTop, Space: 10)
        blurView.contentView.addSubview(alphaBtn)

        quoteBtn = UIButton(frame: CGRect(x: -88, y: 346, width: 88, height: 88))
        quoteBtn.setImageAndTitle(imageName: "Quote", title: "Quote", type: .positionTop, Space: 10)
        blurView.contentView.addSubview(quoteBtn)
        
        chatBtn = UIButton(frame: CGRect(x: -88, y: 506, width: 88, height: 88))
        chatBtn.setImageAndTitle(imageName: "Chat", title: "Chat", type: .positionTop, Space: 10)
        
        photoBtn = UIButton(frame: CGRect(x: view.frame.width + 88, y: 180, width: 88, height: 88))
        photoBtn.setImageAndTitle(imageName: "Photo", title: "Photo", type: .positionTop, Space: 10)
        blurView.contentView.addSubview(photoBtn)
        
        linkBtn = UIButton(frame: CGRect(x: view.frame.width + 88, y: 346, width: 88, height: 88))
        linkBtn.setImageAndTitle(imageName: "Link", title: "Link", type: .positionTop, Space: 10)
        blurView.contentView.addSubview(linkBtn)
        
        audioBtn = UIButton(frame: CGRect(x: view.frame.width + 88, y: 506, width: 88, height: 88))
        audioBtn.setImageAndTitle(imageName: "Audio", title: "Audio", type: .positionTop, Space: 10)
        blurView.contentView.addSubview(audioBtn)
        
        blurView.contentView.addSubview(chatBtn)
    }
    
    @objc func removeBlur() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: .allowAnimatedContent) {
            self.blurView.alpha = 0
            self.alphaBtn.frame.origin.x = -88
            self.quoteBtn.frame.origin.x = -88
            self.chatBtn.frame.origin.x = -88
            
            self.linkBtn.frame.origin.x = self.view.frame.width + 88
            self.photoBtn.frame.origin.x = self.view.frame.width + 88
            self.audioBtn.frame.origin.x = self.view.frame.width + 88
        } completion: { _ in
            self.blurView.removeFromSuperview()
            self.alphaBtn.removeFromSuperview()
            self.quoteBtn.removeFromSuperview()
            self.linkBtn.removeFromSuperview()
            self.photoBtn.removeFromSuperview()
            self.audioBtn.removeFromSuperview()
            self.blurView.removeFromSuperview()
        }

    }
}
