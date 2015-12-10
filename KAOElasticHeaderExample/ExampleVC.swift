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
    private let kTableViewHeaderCutAway: CGFloat = 40.0
    var maskRectangleColor = UIColor.whiteColor()
    
    var headerView: UIView!
    
    var headerMaskLayer = CAShapeLayer()
    var headerMaskView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView = self.tableView.tableHeaderView
        self.tableView.tableHeaderView = nil
        self.tableView.addSubview(self.headerView)
        
        self.tableView.contentInset = UIEdgeInsets(top: kTableViewHeaderHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -kTableViewHeaderHeight)
        
        self.headerMaskView.frame = self.headerView.bounds
        self.headerMaskView.backgroundColor = self.maskRectangleColor
        self.headerView.addSubview(self.headerMaskView)
        
        self.headerMaskView.layer.mask = self.headerMaskLayer
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
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: headerRect.size.width, y: headerRect.size.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.size.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.size.height - kTableViewHeaderCutAway))
        self.headerMaskLayer.path = path.CGPath
        
        self.headerView.frame = headerRect
        self.headerMaskView.frame = self.headerView.bounds
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.updateHeaderView(self.tableView.bounds.width)
    }

}
