//
//  ViewController.swift
//  Lets Be Friends
//
//  Created by Eric Williams on 8/27/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loginHolder = UIView()
    var signupHolder = UIView()
    var buttonsHolder = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Parse.setApplicationId("Vs7IjCMSjlbHErBCJHF2TOLCbMfmsqDmOcO2FLwr",
            clientKey: "wc9zzH2gzTrftpHvjs5tRM9Syn64DVt8uG08ssJM")
        
        var signupButton = UIButton(frame: CGRectMake(10, 10, 145, 40))
        signupButton.setTitle("signup", forState: .Normal)
        signupButton.backgroundColor = UIColor(red: 1, green: 0.3, blue: 0, alpha: 1)
        signupButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        signupButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signupButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        signupButton.addTarget(self, action: Selector("showSignUp"), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(signupButton)
        
        
        var loginButton = UIButton(frame: CGRectMake(165, 10, 145, 40))
        loginButton.setTitle("login", forState: .Normal)
        loginButton.backgroundColor = UIColor(red: 0, green: 0.4, blue: 1, alpha: 1)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        loginButton.addTarget(self, action: Selector("showLogin"), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(loginButton)
    }
    
    func showLogin() {
        
        signupHolder.removeFromSuperview()
        
        
        loginHolder.frame = self.view.frame
        var usernameField = UITextField(frame: CGRectMake(10, 200, 300, 40))
        usernameField.placeholder = "Username"
        loginHolder.addSubview(usernameField)
        
        var passwordField = UITextField(frame: CGRectMake(10, 250, 300, 40))
        passwordField.placeholder = "Password"
        passwordField.secureTextEntry = true
        loginHolder.addSubview(passwordField)
        
        var submitLogin = UIButton(frame: CGRectMake(10, 300, 300, 40))
        submitLogin.setTitle("submit", forState: .Normal)
        submitLogin.backgroundColor = UIColor.lightGrayColor()
        
        submitLogin.addTarget(self, action: Selector("login"), forControlEvents: .TouchUpInside)
        loginHolder.addSubview(submitLogin)
        
        fieldData = [
            "Username":usernameField,
            "Password":passwordField
        ]
        
        self.view.addSubview(loginHolder)
        
    }
    
    func showSignUp() {
        
        loginHolder.removeFromSuperview()
       
        signupHolder.frame = self.view.frame
        
        var emailField = UITextField(frame:CGRectMake(10, 150, 300, 40))
        emailField.placeholder = "Email"
        signupHolder.addSubview(emailField)
        
        var usernameField = UITextField(frame: CGRectMake(10, 200, 300, 40))
        usernameField.placeholder = "Username"
        signupHolder.addSubview(usernameField)
        
        var passwordField = UITextField(frame: CGRectMake(10, 250, 300, 40))
        passwordField.placeholder = "Password"
        passwordField.secureTextEntry = true
        signupHolder.addSubview(passwordField)
        
        var submitSignup = UIButton(frame: CGRectMake(10, 300, 300, 40))
        submitSignup.setTitle("submit", forState: .Normal)
        submitSignup.backgroundColor = UIColor.lightGrayColor()
        
        submitSignup.addTarget(self, action: Selector("signup"), forControlEvents: .TouchUpInside)
        signupHolder.addSubview(submitSignup)
        
        fieldData = [
            "Email":emailField,
            "Username":usernameField,
            "Password":passwordField
        ]
        
        self.view.addSubview(signupHolder)
        
    }

    var fieldData: [String:UITextField]!
    
    func login() {
        
        PFUser.logInWithUsernameInBackground(fieldData["Username"]!.text, password:fieldData["Password"]!.text, block: { (user: PFUser!, error: NSError!) -> Void in
            
            self.loginHolder.removeFromSuperview()
           
            if user != nil {
                println(user.objectForKey("team"))
                
                if user.objectForKey("team") == nil {
                    self.showTeams()
                    
                } else {
                    self.attackMode()
                }
                
            } else {
                println(error)
            }
    
    
        })
    
    }
    
    func signup() {
        
        var user = PFUser()
        
        user.email = fieldData["Email"]!.text
        user.password = fieldData["Password"]!.text
        user.username = fieldData["Username"]!.text
        
        user.signUpInBackgroundWithBlock { (succeeded:Bool, error:NSError!) -> Void in
            
            if succeeded {
            
                print("you are logged in")
                
                self.signupHolder.removeFromSuperview()
            
            } else {
                
                println(error)
            }
            
        }
        
    }
    
    var teamHolder = UIView()
    
    func showTeams() {
        
        teamHolder.frame = self.view.frame
        
        var redTeam = UIButton(frame: CGRectMake(0, 0, 320, UIScreen.mainScreen().bounds.size.height/2.0))
        redTeam.backgroundColor = UIColor.redColor()
        redTeam.tag = 1
        redTeam.addTarget(self, action: Selector("chooseTeam:"), forControlEvents: .TouchUpInside)
        teamHolder.addSubview(redTeam)
        
        var blueTeam = UIButton(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height/2.0, 320, UIScreen.mainScreen().bounds.size.height/2.0))
        blueTeam.backgroundColor = UIColor.blueColor()
        blueTeam.addTarget(self, action: Selector("chooseTeam:"), forControlEvents: .TouchUpInside)
        teamHolder.addSubview(blueTeam)
        
        self.view.addSubview(teamHolder)
        
    }
    
    func chooseTeam(teamButton:UIButton) {
        
        var user = PFUser.currentUser()
        
        switch teamButton.tag {
        case 1 :
            user.setObject("red", forKey: "team")
        default :
            user.setObject("blue", forKey: "team")
        }
        
        user.saveInBackground()
        teamHolder.removeFromSuperview()
        
        attackMode()
    }
    
    func attackMode() {
        
        var installation = PFInstallation.currentInstallation()
        installation.setObject(PFUser.currentUser(), forKey: "user")
        installation.saveInBackground()
        
        var attackButton = UIButton(frame: CGRectMake(10, 200, 300, 40))
        
        attackButton.setTitle("Attack", forState: .Normal)
        attackButton.backgroundColor = UIColor.blackColor()
        
        attackButton.addTarget(self, action: Selector("attack"), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(attackButton)
    }
    
    func attack() {
        
        var user = PFUser.currentUser()
        
        var otherTeam = (user.objectForKey("team") as String == "red") ? "blue" : "red"
        
        var userQuery = PFUser.query()
        userQuery.whereKey("team", equalTo: otherTeam)
        
        userQuery.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            
            println("users \(objects)")
        }
        
        
        var deviceQuery = PFInstallation.query()
        deviceQuery.whereKey("user", matchesQuery:userQuery)

//        deviceQuery.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
//            
//            println(objects)
//        }
        
        var push = PFPush()
        
        push.setQuery(deviceQuery)
        push.setMessage("You have been attacked")
        push.sendPushInBackground()
        
    }

}

