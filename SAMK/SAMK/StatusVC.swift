//
//  StatusVC.swift
//  SAMK
//
//  Created by Eric Williams on 9/22/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit

class StatusVC: UIViewController {
    
    let player1HP = UIView()
    let player2HP = UIView()
    
    let timeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50)
        
        timeLabel.frame = CGRectMake(0, 5, 80, 40)
        timeLabel.center = CGPointMake(self.view.center.x, timeLabel.center.y)
        timeLabel.textAlignment = .Center
        timeLabel.backgroundColor = UIColor.whiteColor()
        timeLabel.text = "00:00"
        timeLabel.font = UIFont(name: "Helvetica-Neue", size: 30)
        self.view.addSubview(timeLabel)
        
        player1HP.frame = CGRectMake(20, 20, (SCREEN_WIDTH - 160) / 2.0, 10)
        player1HP.backgroundColor = UIColor.greenColor()
        self.view.addSubview(player1HP)
        
        player2HP.frame = CGRectMake(SCREEN_WIDTH - (SCREEN_WIDTH - 160) / 2.0 - 20, 20, (SCREEN_WIDTH - 160) / 2.0, 10)
        player2HP.backgroundColor = UIColor.greenColor()
        self.view.addSubview(player2HP)
        
        setHealthForPlayer(80, player: 0)
        setHealthForPlayer(60, player: 1)
        
        
        // Do any additional setup after loading the view.
    }
    
    func setHealthForPlayer (health: CGFloat, player: Int) {
        
        switch player {
            
        case 0 :
            
            for view in player1HP.subviews as [UIView] {
                view.removeFromSuperview()
            }
            
            var lostHealth = UIView(frame: CGRectMake(0, 0, player1HP.frame.size.width - player1HP.frame.size.width / 100 * health, 10))
            
            lostHealth.backgroundColor = UIColor.redColor()
            player1HP.addSubview(lostHealth)
          
        default :
          
            for view in player2HP.subviews as [UIView] {
                view.removeFromSuperview()
                
            }
            
            var lostHealth = UIView(frame: CGRectMake(player2HP.frame.size.width / 100 * health, 0, player2HP.frame.size.width - player2HP.frame.size.width / 100 * health, 10))
            
            lostHealth.backgroundColor = UIColor.redColor()
            player2HP.addSubview(lostHealth)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
