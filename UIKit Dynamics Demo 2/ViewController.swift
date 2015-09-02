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
    var pushBehavior: UIPushBehavior!
    var snapBehavior: UISnapBehavior!
    
    var tapGestureRecognizer: UITapGestureRecognizer!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Box
        self.greenBoxView = UIView(frame: CGRectMake(CGRectGetMidX(self.view.bounds) - (self.greenBoxSize.width / 2), CGRectGetMidY(self.view.bounds) - (self.greenBoxSize.height / 2), self.greenBoxSize.width, self.greenBoxSize.height))
        self.greenBoxView.backgroundColor = UIColor.greenColor()
        self.greenBoxView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 8)) // rotate by 45 deg.
        
        self.view.addSubview(self.greenBoxView)
        
        // MARK: Animation
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        // MARK: Collision behavior
        self.collisionBehavior = UICollisionBehavior(items: [self.greenBoxView])
        self.collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        self.dynamicAnimator.addBehavior(self.collisionBehavior)
        
        // MARK: Push behavior
        self.pushBehavior = UIPushBehavior(items: [self.greenBoxView], mode: UIPushBehaviorMode.Instantaneous)
        self.pushBehavior.setAngle(CGFloat(M_PI / -2), magnitude: 10)
        
        self.dynamicAnimator.addBehavior(self.pushBehavior)
        
        // MARK: Snap behavior
        self.snapBehavior = UISnapBehavior(item: self.greenBoxView, snapToPoint: CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)))
        
        // MARK: Gesture Recognizer
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onTap:")
        self.greenBoxView.addGestureRecognizer(self.tapGestureRecognizer)
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPan:")
        self.greenBoxView.addGestureRecognizer(self.panGestureRecognizer)
    }
    
    // MARK: - Custom Methods
    
    func onTap(tap: UITapGestureRecognizer) {
        self.pushBehavior.active = false
        self.pushBehavior.setAngle(CGFloat(M_PI / -2), magnitude: 10)
        self.pushBehavior.active = true
        self.dynamicAnimator.addBehavior(self.pushBehavior)
    }
    
    func onPan(pan: UIPanGestureRecognizer) {
        self.dynamicAnimator.removeAllBehaviors()
        
        switch pan.state {
            case UIGestureRecognizerState.Began: self.greenBoxView.center = pan.locationOfTouch(0, inView: self.view)
            case UIGestureRecognizerState.Changed: self.greenBoxView.center = pan.locationOfTouch(0, inView: self.view)
            case UIGestureRecognizerState.Ended: self.dynamicAnimator.addBehavior(self.snapBehavior)
            default: return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

