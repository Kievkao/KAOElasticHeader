//
//  ExampleVC.swift
//  KAOElasticHeaderExample
//
//  Created by Andrii Kravchenko on 12/9/15.
//  Copyright © 2015 Andrii Kravchenko. All rights reserved.
//

import UIKit

class ExampleVC: UITableViewController {

    private let kTableViewHeaderHeight: CGFloat = 200.0
    var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView = self.tableView.tableHeaderView
        self.tableView.tableHeaderView = nil
        self.tableView.addSubview(self.headerView)
        
        self.tableView.contentInset = UIEdgeInsets(top: kTableViewHeaderHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -kTableViewHeaderHeight)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.updateHeaderView(size.width)
    }
    
    func updateHeaderView(parentWidth: CGFloat) {
        
        var headerRect = CGRect(x: 0, y: -kTableViewHeaderHeight, width: parentWidth, height: kTableViewHeaderHeight)
        
        if self.tableView.contentOffset.y < kTableViewHeaderHeight {
            headerRect.origin.y = self.tableView.contentOffset.y
            headerRect.size.height = -self.tableView.contentOffset.y
        }
        
        self.headerView.frame = headerRect
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.updateHeaderView(self.tableView.bounds.width)
    }

}
