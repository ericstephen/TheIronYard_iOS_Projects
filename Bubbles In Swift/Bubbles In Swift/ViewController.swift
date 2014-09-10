//
//  ViewController.swift
//  Bubbles In Swift
//
//  Created by Eric Williams on 9/5/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit

import AVFoundation

func degreesToRadians(degrees: UInt32) -> Double {
    return Double(degrees) * M_PI / 180.0
}

class ViewController: UIViewController, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    var bubble: UIView!
    
    var audioSession = AVAudioSession()
    var audioDataOutput = AVCaptureAudioDataOutput()
    var audioCaptureSession = AVCaptureSession()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.brownColor()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        audioSession.setCategory(AVAudioSessionCategoryRecord, error: nil)
        audioSession.setMode(AVAudioSessionModeMeasurement, error: nil)
        audioSession.setActive(true, error: nil)
        audioSession.setPreferredSampleRate(48000, error: nil)
        // // adds microphone
        var device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        var audioCaptureInput = AVCaptureDeviceInput(device: device, error: nil)
        
        audioCaptureSession.addInput(audioCaptureInput)
        audioDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, CUnsignedLong()))
        
        audioCaptureSession.addOutput(audioDataOutput)
        
        audioCaptureSession.startRunning()
        
    }
    
    /////////// HOMEWORK //////////
    
    // // only blow bubbles if peak or power passes a number -- CHECK
    
    // //  after animation finishes remove bubble from screen
    // // find a cool image online that can be a bubble lightning bolt, fire, etc  -- CHECK
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        for channel : AnyObject in connection.audioChannels {
            
            println("peak \(channel.peakHoldLevel) and average power \(channel.averagePowerLevel)")
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if channel.peakHoldLevel > -5 {
                    
                    self.createBubble()
                }
            

            })
        }
    }
    
    let height = UIScreen.mainScreen().bounds.size.height
    let width = UIScreen.mainScreen().bounds.size.width
    
    
    func createBubble() {
        
        var bubble = UIView(frame: CGRectMake(0, 0, 20, 20))
        bubble.center = CGPointMake(width / 2 , height)
        bubble.backgroundColor = UIColor(patternImage: UIImage(named: "twitter"))
        bubble.layer.cornerRadius = 10
        
        self.view.addSubview(bubble)
        
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                                let x = CGFloat(arc4random_uniform(UInt32(self.width)))
                let y = CGFloat(arc4random_uniform(UInt32(self.height)))
                
                bubble.center = CGPointMake(x, y)
                
                var radians = degreesToRadians(arc4random_uniform(360))
                UIView.animateWithDuration(0.01, animations: { () -> Void in
                    bubble.transform = CGAffineTransformMakeRotation(CGFloat(radians))
                
            }, completion: { (Bool) -> Void in
                
                bubble.removeFromSuperview()
            })
        
            })
            
        })
    }
}