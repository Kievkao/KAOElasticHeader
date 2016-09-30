//
//  ExampleVC.swift
//  KAOElasticHeaderExample
//
//  Created by Andrii Kravchenko on 12/9/15.
//  Copyright © 2015 Andrii Kravchenko. All rights reserved.
//

import UIKit

class ImageBackgroundVC: UITableViewController {

    fileprivate let kTableViewHeaderHeight: CGFloat = 200.0
    fileprivate let kTableViewHeaderCutAway: CGFloat = 40.0
    var maskRectangleColor = UIColor.white
    
    fileprivate var headerView: UIView!
    
    fileprivate var headerMaskLayer = CAShapeLayer()
    fileprivate var headerMaskView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.setupMaskView()
    }
    
    func setupMaskView() {
        self.headerMaskView.frame = self.headerView.bounds
        self.headerMaskView.backgroundColor = self.maskRectangleColor
        self.headerView.addSubview(self.headerMaskView)
        
        self.headerMaskView.layer.mask = self.headerMaskLayer
    }
    
    func setupTableView() {
        self.headerView = self.tableView.tableHeaderView
        self.tableView.tableHeaderView = nil
        self.tableView.addSubview(self.headerView)
        
        self.tableView.contentInset = UIEdgeInsets(top: kTableViewHeaderHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -kTableViewHeaderHeight)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.updateHeaderView(size.width)
    }
    
    func updateHeaderView(_ parentWidth: CGFloat) {
        
        var headerRect = CGRect(x: 0, y: -kTableViewHeaderHeight, width: parentWidth, height: kTableViewHeaderHeight)
        
        if self.tableView.contentOffset.y < kTableViewHeaderHeight {
            headerRect.origin.y = self.tableView.contentOffset.y
            headerRect.size.height = -self.tableView.contentOffset.y
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: headerRect.size.width, y: headerRect.size.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.size.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.size.height - kTableViewHeaderCutAway))
        self.headerMaskLayer.path = path.cgPath
        
        self.headerView.frame = headerRect
        self.headerMaskView.frame = self.headerView.bounds
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateHeaderView(self.tableView.bounds.width)
    }
}
