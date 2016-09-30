//
//  SolidBackgroundVC.swift
//  KAOElasticHeaderExample
//
//  Created by Andrii Kravchenko on 12/10/15.
//  Copyright © 2015 Andrii Kravchenko. All rights reserved.
//

import UIKit

class SolidBackgroundVC: UITableViewController {

    fileprivate let kTableViewHeaderHeight: CGFloat = 200.0
    fileprivate let kCenterImageViewDiameter: CGFloat = 100.0

    @IBOutlet weak var centerImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerImageView: UIImageView!
    fileprivate var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.setupCenterImageView()
    }
    
    func setupCenterImageView() {
        self.centerImageView.layer.cornerRadius = 50.0
        self.centerImageView.clipsToBounds = true
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
        var centerImageViewDiameter = self.kCenterImageViewDiameter
        
        if self.tableView.contentOffset.y < kTableViewHeaderHeight {
            headerRect.origin.y = self.tableView.contentOffset.y
            headerRect.size.height = -self.tableView.contentOffset.y
            
            // process controllers in navigation stack with top bar
            var additionalShift: CGFloat = 0;
            if let navBar  = self.navigationController?.navigationBar , !navBar.isHidden {
                additionalShift += self.view.frame.origin.y - navBar.frame.size.height
            }
            centerImageViewDiameter += abs(self.tableView.contentOffset.y + kTableViewHeaderHeight) + additionalShift
        }
        
        self.centerImageViewWidthConstraint.constant = centerImageViewDiameter
        self.centerImageView.layer.cornerRadius = centerImageViewDiameter / 2
        self.headerView.frame = headerRect
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateHeaderView(self.tableView.bounds.width)
    }
}
