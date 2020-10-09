//
//  3DTouchQuickAction.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/21.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit
import SafariServices

class ThreeDTouchQuickAction: UIViewController, UIViewControllerPreviewingDelegate, UIContextMenuInteractionDelegate {

    var actionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        actionLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 400, height: 50))
        actionLabel.text = "Please Press the 3D action"
        view.addSubview(actionLabel)
        
        let notificationName = Notification.Name(rawValue: "ShortcutAction")
        NotificationCenter.default.addObserver(self, selector: #selector(shortCutActionClicked(sender:)), name: notificationName, object: nil)
        
        let fingerPrintImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 128, height: 128))
        fingerPrintImageView.image = UIImage(named: "fingerprint")
        fingerPrintImageView.isUserInteractionEnabled = true
        view.addSubview(fingerPrintImageView)
        fingerPrintImageView.center = view.center

        if #available(iOS 13.0, *) {
            let interaction = UIContextMenuInteraction(delegate: self)
            view.addInteraction(interaction)
        } else {
            registerForPreviewing(with: self, sourceView: view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func changeLabel(with name: String) {
        actionLabel.text = name
    }
    
    @objc func shortCutActionClicked(sender: Notification) {
        let shortcutItem = sender.userInfo?["shortcutItem"] as! UIApplicationShortcutItem
        if shortcutItem.type == "LoveItem" {
            changeLabel(with: "Yes, I do ❤️ you!")
        }
    }

    //MARK: - UIContextMenuInteractionDelegate
    @available(iOS 13.0, *)
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

        return UIContextMenuConfiguration(identifier: nil) { () -> UIViewController? in
            // 需要展示的控制器
            return SFSafariViewController(url: NSURL(string: "http://www.qq.com")! as URL)
        } actionProvider: { (list) -> UIMenu? in
            let copy = UIAction(title: "Copy", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off, handler: { (_) in
                print("Copy")
            })
            let duplicate = UIAction(title: "Duplicate", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off, handler: { (_) in
                print("Duplicate")
            })

            let editMenu = UIMenu(title: "Edit...", image: nil, identifier: nil, options: [], children: [ copy, duplicate ])

            let share = UIAction(title: "Share", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off, handler: { (_) in
                print("Share")
            })

            let delete = UIAction(title: "Delete", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [.destructive], state: .off, handler: { (_) in
                print("Delete")
            })

            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [share, editMenu, delete])
        }

    }

    //MARK: - UIViewControllerPreviewingDelegate
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // 通过上下文可以调整不被虚化的范围
        previewingContext.sourceRect = CGRect(x: 10, y: 10, width: view.frame.width - 20, height: view.frame.height - 10)
        return SFSafariViewController(url: NSURL(string: "http://www.qq.com")! as URL)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }

}

extension SFSafariViewController {
    open override var previewActionItems: [UIPreviewActionItem] {
        let deleteAction = UIPreviewAction(title: "删除", style: .destructive) { (_, _) in
            print("Delete")
        }
        let doneAction = UIPreviewAction(title: "完成", style: .default) { (_, _) in
            print("Done")
        }
        return [deleteAction, doneAction]
    }
}
