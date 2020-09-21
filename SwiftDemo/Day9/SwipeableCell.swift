//
//  Swipeable Cell.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/20.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit

class SwipeableCell: UIViewController, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate {
    
    private let cellHeight: CGFloat = 66
    private let colorRatio: CGFloat = 10
    private var actionController: UIAlertController!
    var table: UITableView!
    private let lyric = "when i was young i'd listen to the radio,waiting for my favorite songs,when they played i'd sing along,it make me smile,those were such happy times and not so long ago,how i wondered where they'd gone,but they're back again just like a long lost friend,all the songs i love so well,every shalala every wo'wo,still shines,every shing-a-ling-a-ling"
    private var dataSource: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        table = UITableView(frame: view.frame)
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        dataSource = lyric.split(separator: ",").map(String.init)
        
        actionController = UIAlertController(title: "", message: "", preferredStyle: .alert)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
        let cells = table.visibleCells
        let tableHeight: CGFloat = table.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            cell.frame.origin.y = tableHeight
            UIView.animate(withDuration: 1.0, delay: 0.04 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.frame.origin.y = 0
            }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "animationInTableViewCell")
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: cellHeight))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bgView.frame
        let lowerColor: CGColor = UIColor(red: (CGFloat(indexPath.row * 2) * colorRatio)/255.0, green: 1.0, blue: (CGFloat(indexPath.row * 2) * colorRatio)/255.0, alpha: 1).cgColor
        let upperColor: CGColor = UIColor(red: (CGFloat(indexPath.row * 2) * colorRatio + colorRatio)/255.0, green: 1.0, blue: (CGFloat(indexPath.row * 2) * colorRatio + colorRatio)/255.0, alpha: 1).cgColor

        gradientLayer.colors = [lowerColor, upperColor]
        bgView.layer.addSublayer(gradientLayer)
        cell.addSubview(bgView)
        cell.sendSubviewToBack(bgView)
        cell.frame.origin.y = cellHeight
        
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let likeAction = UIContextualAction(style: .normal, title: "👍") { (_, _, comlpete) in
         self.actionController.message = "Thanks for your Love😸"
         self.showAlertController()
         comlpete(true)
         }
         
         let dislikeAction = UIContextualAction(style: .normal, title: "👎") { (_, _, comlpete) in
             self.actionController.message = "Tell me why!!!😤"
             self.showAlertController()
             comlpete(true)
          }
         
         let unknowAction = UIContextualAction(style: .normal, title: "🖖") { (_, _, comlpete) in
             self.actionController.message = "What do you mean? 🤔"
             self.showAlertController()
             comlpete(true)
          }
         
       return UISwipeActionsConfiguration(actions: [likeAction, dislikeAction, unknowAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
       let likeAction = UIContextualAction(style: .normal, title: "👍") { (_, _, comlpete) in
        self.actionController.message = "Thanks for your Love😸"
        self.showAlertController()
        comlpete(true)
        }
        
        let dislikeAction = UIContextualAction(style: .normal, title: "👎") { (_, _, comlpete) in
            self.actionController.message = "Tell me why!!!😤"
            self.showAlertController()
            comlpete(true)
         }
        
        let unknowAction = UIContextualAction(style: .normal, title: "🖖") { (_, _, comlpete) in
            self.actionController.message = "What do you mean? 🤔"
            self.showAlertController()
            comlpete(true)
         }
        
      return UISwipeActionsConfiguration(actions: [likeAction, dislikeAction, unknowAction])
    }

    func showAlertController() {
        self.present(self.actionController, animated: true, completion: {
            let dismissTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in
                self.actionController.dismiss(animated: true, completion: nil)
            })
            RunLoop.main.add(dismissTimer, forMode: RunLoop.Mode.common)
        })
    }
}
