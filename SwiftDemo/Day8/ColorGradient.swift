//
//  ColorGradient.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/20.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class ColorGradient: UIViewController, CAAnimationDelegate {
    
    var gradientLayer: CAGradientLayer!
    var colorSets = [[CGColor]]()
    var currentColorSet: Int!
    let brightestSkyColorR = 21.0
    let brightestSkyColorG = 105.0
    let brightestSkyColorB = 203.0
    let darkestSkyColorR = 8.0
    let darkestSkyColorG = 33.0
    let darkestSkyColorB = 63.0
    
    let highestTemperatureColorR = 255.0
    let highestTemperatureColorG = 200.0
    let highestTemperatureColorB = 101.0
    let lowestTemperatureColorR = 47.0
    let lowestTemperatureColorG = 169.0
    let lowestTemperatureColorB = 199.0
    
    let lowestTemperature = 18
    let highestTemperature = 41
    
    var totalIndex = 0
    var timeLabel: UILabel!
    var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handelPanGesture(sender:)))
        view.addGestureRecognizer(panGestureRecognizer)
        createColorSets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.createGradientLayer()
        
        timeLabel = UILabel(frame: CGRect(x: 50, y: 40, width: 100, height: 100))
        timeLabel.text = "1:00"
        timeLabel.textColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 28)
        view.addSubview(timeLabel)
        
        temperatureLabel = UILabel(frame: CGRect(x: 250, y: 40, width: 100, height: 100))
        temperatureLabel.text = "18 ℃"
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont.systemFont(ofSize: 28)
        view.addSubview(temperatureLabel)
    }

    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        //设置渐变的主颜色
        gradientLayer.colors = colorSets[currentColorSet]
        //将gradientLayer作为子layer添加到主layer上
        view.layer.addSublayer(gradientLayer)
    }
    
    func createColorSets() {
        for index in 1...12 {
            colorSets.append(colorSet(index: Double(index)))
        }
        currentColorSet = 0
    }

    var lastY: CGFloat = 0.0, lastTotalIndex = 0, deltaOrigin = 0, indexForUp = 0
    @objc func handelPanGesture(sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: self.view)
        let tranY = sender.translation(in: self.view).y
        if lastY == 0 || tranY * lastY < 0 {
            lastY = tranY
            lastTotalIndex = totalIndex
        }
        let scopeY = self.view.frame.height / 24.0
//        time ++ up to down
        if velocity.y > 0 && totalIndex < 23 {
            totalIndex = Int((tranY - lastY) /  scopeY)
            if totalIndex == 0 {
                deltaOrigin = lastTotalIndex
            }
            totalIndex += deltaOrigin
            lastTotalIndex = totalIndex
//            print("time++ : index-> \(totalIndex)")
        }
        
//        time -- down to up
        if velocity.y < 0 && totalIndex > 1 {
            indexForUp = Int((tranY - lastY) / scopeY)
            if indexForUp == 0 {
                deltaOrigin = lastTotalIndex
            }
            totalIndex = deltaOrigin + indexForUp
            lastTotalIndex = totalIndex
        }
        changeColor()
        changeLabels()
    }
    
    func changeColor() {
        guard lastTotalIndex > 0 && lastTotalIndex < 24 else {
            return
        }
        if lastTotalIndex < 12 {
            gradientLayer.colors = colorSets[lastTotalIndex]
        } else {
            gradientLayer.colors = colorSets[23 - lastTotalIndex]
        }
    }
    
    func changeLabels() {
        guard lastTotalIndex > 0 && lastTotalIndex < 25 else {
            return
        }
        if lastTotalIndex < 12 {
            temperatureLabel.text = "\(lowestTemperature + lastTotalIndex) ℃"
        } else {
            temperatureLabel.text = "\(highestTemperature - lastTotalIndex) ℃"
        }
        timeLabel.text = "\(lastTotalIndex):00"
    }
    
//    index: 1 - 12
    func colorSet(index: Double) -> [CGColor] {
        let skyr = darkestSkyColorR + (brightestSkyColorR - darkestSkyColorR) * (index - 1) / 11.0
        let skyg = darkestSkyColorG + (brightestSkyColorG - darkestSkyColorG) * (index - 1) / 11.0
        let skyb = darkestSkyColorB + (brightestSkyColorB - darkestSkyColorB) * (index - 1) / 11.0
        
        let tmprr = lowestTemperatureColorR + (highestTemperatureColorR - lowestTemperatureColorR) * (index - 1) / 11.0
        let tmprg = lowestTemperatureColorG + (highestTemperatureColorG - lowestTemperatureColorG) * (index - 1) / 11.0
        let tmprb = lowestTemperatureColorB + (highestTemperatureColorB - lowestTemperatureColorB) * (index - 1) / 11.0
        
        return [UIColor(red: CGFloat(skyr/255.0), green: CGFloat(skyg/255.0), blue: CGFloat(skyb/255.0), alpha: 1).cgColor,
                UIColor(red: CGFloat(tmprr/255.0), green: CGFloat(tmprg/255.0), blue: CGFloat(tmprb/255.0), alpha: 1).cgColor]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
