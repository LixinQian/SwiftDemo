//
//  SimplePhotoBrowser.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/20.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class SimplePhotoBrowser: UIViewController, UIScrollViewDelegate {
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "samplePhoto.jpeg")
        imageView.isUserInteractionEnabled = true
        scrollView = UIScrollView(frame: view.frame)
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1
        scrollView.backgroundColor = .black
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
