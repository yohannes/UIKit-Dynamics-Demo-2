//
//  ViewController.swift
//  UIKit Dynamics Demo 2
//
//  Created by Yohannes Wijaya on 9/2/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    let greenBoxSize = CGSizeMake(100.0, 100.0)
    var greenBoxView: UIView!
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Box
        self.greenBoxView = UIView(frame: CGRectMake(CGRectGetMidX(self.view.bounds) - (self.greenBoxSize.width / 2), CGRectGetMidY(self.view.bounds) - (self.greenBoxSize.height / 2), self.greenBoxSize.width, self.greenBoxSize.height))
        self.greenBoxView.backgroundColor = UIColor.greenColor()
        self.greenBoxView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 8))
        
        self.view.addSubview(self.greenBoxView)
        
        // MARK: Animation
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        // MARK: Collision
        self.collisionBehavior = UICollisionBehavior(items: [self.greenBoxView])
        self.collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        self.dynamicAnimator.addBehavior(self.collisionBehavior)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

