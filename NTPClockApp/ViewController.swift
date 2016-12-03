//
//  ViewController.swift
//  NTPClockApp
//
//  Created by Syafiq on 12/3/16.
//  Copyright © 2016 Syafiq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!

    @IBOutlet weak var syncButton: UIButton! {
        didSet {
            
            
            syncButton.addTarget(self, action: #selector(self.handleSyncButton(sender:)), for: .touchUpInside)
        }
    }
    
    var timer = Timer()
    var count = 600
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date()
       // let dateFormatter = DateFormatter()
        
        
        
        let networkClock = NetworkClock.shared()
        let networkTime = networkClock?.networkTime
        
        currentTime.text = "\(networkTime)"
        
        self.startTimer()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTimer() {
        
        if(count > 0){
            

      //      let minutes = String(count / 60)
            
          //  let seconds = String(count % 60)
            
            var minString : String = ""
            var secString : String = ""
            
            let minutes = count / 60
            let seconds = count % 60

            if seconds < 10 {
                secString = "0" + String(seconds)
            }else {
                secString = String(seconds)
            }
            
            if minutes < 10 {
                minString = "0" + String(minutes)
            }else {
                minString = String(minutes)
            }
            
            
            secondsLabel.text = minString + ":" + secString
    
            
            count = count - 1
        }
        
    }
    
    func handleSyncButton(sender : UIButton) {
        self.timer.invalidate()
        
        startTimer()
    }
    
    func startTimer() {
        count = 600
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
}

