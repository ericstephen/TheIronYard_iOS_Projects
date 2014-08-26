//
//  ViewController.swift
//  SwiftInParse
//
//  Created by Eric Williams on 8/26/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Parse.setApplicationId("CHrByCncfOZCQyv8LI94f9bJLyj4XONFoEHFPtML", clientKey: "cDzT2j8AbNWG8zgQkeRi541qDrr4TytQJ0vIjyob")
        
        var face = PFObject(className: "Faces")
        
        face.setObject("round", forKey: "shape")
        face.setObject("eric", forKey: "person")
        face.setObject("beard", forKey: "facialhair")
        face.saveInBackground()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

