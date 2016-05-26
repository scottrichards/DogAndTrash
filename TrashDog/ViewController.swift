//
//  ViewController.swift
//  TrashDog
//
//  Created by Scott Richards on 5/24/16.
//  Copyright © 2016 Baby Center. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var dogView : UIImageView?
    var trashView : UIImageView?
    var startLocation : CGPoint?
    var dogGone : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dogView = UIImageView(frame: CGRect( x: 40, y: 100, width : 150, height : 150))
        self.trashView = UIImageView(frame: CGRect( x: 140, y: 360, width: 200, height : 200))
        self.dogView?.image = UIImage(named:"dog")
        self.trashView?.image = UIImage(named: "trash")
        self.view.addSubview(trashView!)
        self.view.addSubview(dogView!)
        startLocation = dogView?.center
        self.dogView?.userInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target : self, action: "dragDog:")
        //panGestureRecognizer.delegate = self
        self.dogView!.addGestureRecognizer(panGestureRecognizer)
        let screenTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapScreen:")
        self.view.addGestureRecognizer(screenTapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dragDog(panGesture:UIPanGestureRecognizer) {
        let translation : CGPoint = panGesture.translationInView(self.view)
        
        dogView!.center = CGPoint(x: startLocation!.x + translation.x, y: startLocation!.y + translation.y)
        print("dog pos x: \(dogView!.center.x) y:\(dogView?.center.y)")
        if (CGRectIntersectsRect(dogView!.frame,trashView!.frame)) {
            if (panGesture.state == UIGestureRecognizerState.Ended) {
                dogView!.removeFromSuperview()
                dogGone = true
            }
        }
        if (panGesture.state == UIGestureRecognizerState.Ended) {
            animateBack()
        }
    }
    
    // animate dog back to its original position 
    func animateBack()
    {
        
        
        UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseOut, animations: {
            self.dogView!.center = self.startLocation!
        }, completion: { finished in
            print("Dog back home")
        })

    }
    func tapScreen(tapGesture:UITapGestureRecognizer) {
        if (dogGone) {
            dogGone = false
            dogView!.center = startLocation!
            self.view.addSubview(dogView!)
        }
    }
}




