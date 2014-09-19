//
//  ViewController.swift
//  Reaxion
//
//  Created by Eric Williams on 9/18/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit
import GameKit

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height


class ViewController: UIViewController {
    
    let timeBar = UIView()
    let buttons = [UIButton(), UIButton(), UIButton()]
    var timer: NSTimer?
    let scoreLabel = UILabel()
    var currentScore = 0
    var buttonToTap = 0
    var player = GKLocalPlayer.localPlayer()
    var allLeaderboards: [String:GKLeaderboard] = Dictionary()
    
    var startReactionTime: NSDate!
    var endReactionTime: NSDate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //first color
        var topColor = UIColor(red: 0.910, green: 0.976, blue: 0.333, alpha: 1.0)
        //second color
        var bottomColor = UIColor(red: 0.973, green: 0.204, blue: 0.333, alpha: 1.0)
        //array of colors in gradient
        var gradientColors: [AnyObject] = [topColor.CGColor, bottomColor.CGColor]
        //array of locations for colors in gradient
        var gradientLocations = [0.0, 1.0]
        //gradient layer with adjusted angle
        var gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.startPoint = CGPointMake(0.6, -0.1)
        gradientLayer.endPoint = CGPointMake(0.4, 1.1)
        //add colors to gradient layer
        gradientLayer.colors = gradientColors;
        //add locations to gradient layer
        gradientLayer.locations = gradientLocations
        //add gradient to view as background
        self.view.layer.addSublayer(gradientLayer)
        
        for i  in 0..<buttons.count {
            
            var button = buttons[i]
            
            var size: CGFloat = 100.0
            
            var x = ((SCREEN_WIDTH - size) / 2.0)
            var y = ((SCREEN_HEIGHT - size) / 2.0) + (CGFloat(i - 1.0) * (size + 20))
            
            button.alpha = 0.6
            button.frame = CGRectMake(x, y, size, size)
            button.layer.cornerRadius = size / 2.0
            button.backgroundColor = UIColor.whiteColor()
            button.tag = i
            
            button.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: .TouchUpInside)
            
            self.view.addSubview(button)
        }
        
        timeBar.backgroundColor = UIColor.whiteColor()
        timeBar.frame = CGRectMake(0, 0, 0, 20)
        self.view.addSubview(timeBar)
        
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        
        dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue()) { () -> Void in
            
            self.runLevel()
        }
        
        var nc = NSNotificationCenter.defaultCenter()
        
        nc.addObserver(self, selector: Selector("authChanged"), name: GKPlayerAuthenticationDidChangeNotificationName, object: nil)
        
        
        if player.authenticated == false {
            
            player.authenticateHandler = { (viewController, error) -> Void in
                
                if viewController != nil {
                    self.presentViewController(viewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func buttonTapped(button: UIButton) {
        
        println(button.tag)
        
        if buttonToTap == button.tag {
            
            endReactionTime = NSDate()
            
            let reactionTime = endReactionTime.timeIntervalSinceDate(startReactionTime)
            
            submitReactionTime(reactionTime)
            
            currentScore++
            checkAchievement()
            runLevel()
            
        } else {
            
            currentScore = 0
            submitScore()
            
            var time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
            
            dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue()) { () -> Void in
                
                self.runLevel()
            }
        }
        
    }
    
    func runLevel() {
        
        startReactionTime = NSDate()
        
        buttonToTap = Int(arc4random_uniform(3))
        
        var button = buttons[buttonToTap]
        
        button.alpha = 1.0
        
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
            button.alpha = 0.6
            
            }) { (success: Bool) -> Void in
                
        }
        resetTimerWithSpeed(10)
    }
    
    func resetTimerWithSpeed(speed: Double) {
        
        if timer != nil { timer!.invalidate() }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(speed, target: self, selector: Selector("timerDone"), userInfo: nil, repeats: false)
        
        timeBar.frame.size.width = SCREEN_WIDTH
        timeBar.layer.removeAllAnimations()
        
        UIView.animateWithDuration(speed, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.timeBar.frame.size.width = 0
            
            }) { (success) -> Void in
        }
    }
    
    func timerDone() {
        
        println("Game Over")
        
    }
    
    func authChanged() {
        
        if player.authenticated == false { return }
        
        GKLeaderboard.loadLeaderboardsWithCompletionHandler { (leaderboards, error) -> Void in
            
            
            for leaderboard in leaderboards as [GKLeaderboard] {
                
                var identifier = leaderboard.identifier
                
                self.allLeaderboards[identifier] = leaderboard
                
            }
        }
    }
    
    func submitScore() {
        
        var scoreReporter = GKScore(leaderboardIdentifier: "total_taps")
        
        scoreReporter.value = Int64(currentScore)
        scoreReporter.context = 0
        
        GKScore.reportScores([scoreReporter], withCompletionHandler: { (error) -> Void in
            
            println("score reported")
            
        })
    }
    
    func checkAchievement() {
        
        if currentScore >= 50 {
            
            var score50 = GKAchievement(identifier: "score_50")
            
            score50.percentComplete = 100.0
            score50.showsCompletionBanner = true
            
            GKAchievement.reportAchievements([score50], withCompletionHandler: { (error) -> Void in
                
                println("achievement sent")
            })
        }
    }
    
    func submitReactionTime(time: NSTimeInterval) {
        
        var scoreReporter = GKScore(leaderboardIdentifier: "reaction_time")
        
        scoreReporter.value = Int64(time * 100.0)
        scoreReporter.context = 0
        
        GKScore.reportScores([scoreReporter], withCompletionHandler: { (error) -> Void in
            
            println("reaction time reported")
            
        })
        
    }
}

